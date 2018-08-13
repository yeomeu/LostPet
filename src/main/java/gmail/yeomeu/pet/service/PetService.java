package gmail.yeomeu.pet.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.parser.Parser;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.thymeleaf.ITemplateEngine;
import org.thymeleaf.context.Context;

import gmail.yeomeu.pet.Util;
import gmail.yeomeu.pet.dao.PetDao;
import gmail.yeomeu.pet.dto.LostPet;
import gmail.yeomeu.pet.dto.PetType;
import gmail.yeomeu.pet.dto.RemoteLostPet;
import gmail.yeomeu.pet.dto.User;
/**
 * java reflection 
 * @author yeom
 *
 */
@Service
public class PetService {

	@Inject
	PetDao petDao;
	
	@Inject
	MapApiService apiService;
	
	@Inject
	MailService mailService;
	
	@Inject ITemplateEngine engine;
	
	public List<PetType> findPetTypes () {
		return petDao.findPetTypes();
	}

	public void registerLostPet(LostPet lostPet) {
		petDao.insertLostPet ( lostPet );
	}

	public List<LostPet> findLostList() {
		List<LostPet> lostPet = petDao.findLostList();
		return lostPet;
	}

	public List<String> findBreeds(String keyword) {
		List<String> breeds = petDao.findBreeds(keyword);
		return breeds;
	}
	
	@Scheduled(cron="55 59 23 * * ? ")
//	@Scheduled(cron="0/2 * * * * ? ")
	public void loadPublicData() {
//		String yesterDay = "20180625";
//		System.out.println("called!@");
		String today = Util.today("yyyyMMdd");
		 doLoadData (today, today);
	}

	private @Value("${openapi.animal.uri}") String url;
	public void doLoadData(String start, String end) {
		String api_uri = this.url;
		String url = api_uri.replace(":sd", start)
				            .replaceAll(":ed", end);
		Connection con = Jsoup.connect(url);
		con.parser(Parser.xmlParser());

		System.out.println(url);
	//	boolean t = true;
	//	if ( t ) throw new RuntimeException();
		
		Document doc;
		try {
			
			doc = con.timeout(60*1000).get();
			Elements elems = doc.select("response body items item");
			RemoteLostPet pet = new RemoteLostPet();
			
			// [ 차와와, 말라뮤트, 시츄, 치와와]
			Map<String, List<RemoteLostPet>> breedMap = new HashMap<>();
			
			for( Element each : elems ) {
				
				// 1. each => LostPetInfo 
				// 2. inser to db
				
				pet.setDesertionNo(Long.parseLong(each.select("desertionNo").text()));
				pet.setCareAddr(each.select("careAddr").text());
				pet.setCareNm(each.select("careNm").text());
				pet.setCareTel(each.select("careTel").text());
				pet.setChargeNm(each.select("chargeNm").text());
				pet.setPopfile(each.select("popfile").text());
				
				System.out.println("animalImg >> "+each.select("popfile").text());
				
				pet.setHappenDt(each.select("happenDt").text());
				pet.setHappenPlace(each.select("happenPlace").text());
				// each.select("kindCd").text()
				// [개] 시츄 ==> 시츄 ==> pets테이블이 이 값이 있어야 함!
				// [고양이] 친칠라
				String kc = each.select("kindCd").text();
				int p = kc.indexOf(']');
				kc = kc.substring(p+1).trim(); // kc = kc.substring(p+1, kc.length());
				// FIXME kc 가 empty string일 수 있음 
				pet.setKindCd(kc);
				pet.setSexCd(each.select("sexCd").text());
				pet.setNoticeSdt(each.select("noticeSdt").text());
				pet.setNoticeEdt(each.select("noticeEdt").text());
				pet.setNoticeNo(each.select("noticeNo").text());
				pet.setOfficeTel(each.select("officeTel").text());
				
//				MapApiService apiService = new MapApiService();
				double [] latlng = apiService.findCoord ( pet.getCareAddr());
				pet.setLat ( latlng[0] ); // error!
				pet.setLng ( latlng[1] ); // error!
				//list.add(petµ);
//				String s = null;
//				s.length();
				
				petDao.insertRemoteLostPet(pet);
				// [ 차와와, 말라뮤트, 시츄, 치와와]
				// { "치와와" : [ (0), (1) ]
				//   "말라뮤트" : [(0) ] 
				//   "시츄" : [(0) ] 
				// }
				String key = pet.getKindCd();
				List<RemoteLostPet> animals = breedMap.get(key);
				if (animals == null ) {
					animals = new ArrayList<>();
					breedMap.put(key, animals); // 등록
				}
				animals.add(pet);
				// breedMap.putIfAbsent(key, value)
			} // end-for
			
			startMatching( breedMap );
		} catch (IOException e) {
			e.printStackTrace();
		}
		// System.out.println(doc.toString());
	}
	
	public void startMatching(Map<String, List<RemoteLostPet> > breedMap ) {
		/*
		 * { "치와와"   : [ (0), (1) ]
		     "말라뮤트" : [(0) ] 
			  "시츄"   : [(0) ] 
			 }
		 */
		/* 
		 * 1. pet 축종과 일치하는 레코드들을 읽어들임 ( 통보:=Yes and 축종 일치 and 날짜 ) : lostPets(List)
		 *    1.1. db에 컬럼 추가
		 *    1.2. dto 수정 
		 *    1.3. mybatis resultMap 에 반영
		 *    1.4. 조회 쿼리 작성 (dao, mybatis sql )
		 *    
		 * 2. owner에게 메일 전송
		 *    2.1. 메일 내용 템플릿(html)
		 */
		
		System.out.println("startMatching START =======================");
		
		Context ctx = new Context();
		for ( String key : breedMap.keySet()) {
			List<RemoteLostPet> pets ;
			pets = breedMap.get(key);
			// 조회 쿼리 작성 (dao, mybatis sql )
			
			// TODO 제목도 템플릿으로 빼내고 싶음
			String title = "[DEMO] 유기동물 {{breed}} 메일링".replaceAll("{{breed}}", key);
			
			List<LostPet> owners = petDao.findMatchingPets(key, null);
			for ( LostPet each : owners) {
				
				User user = new User();
				user.setEmail(each.getEmail());
				
				ctx.clearVariables();
				ctx.setVariable("user", user);
				ctx.setVariable("pets", pets);
				String content = engine.process("tpl-lost-pets", ctx);
				
				mailService.sendMail(user, title, content);
			}
		}
	}
	public List<RemoteLostPet> findLostPets(String since, String petType) {
		return petDao.findLostPets( since, petType );
	}
	
	/**
	 * 유기동물조회 조회조건의 '품종'조건
	 */
	public void getPetBreed(String breedCode, String breedType) {
			
		// 축종코드 개 : 417000 - 고양이 : 422400 - 기타 : 429900
//		String up_kind_cd = "417000";
//		String api_uri = "http://openapi.animal.go.kr/openapi/service/rest/abandonmentPublicSrvc/kind?serviceKey=rFLSToMpG8eKdRK3iDnyv4O1YKfGwXhnS%2FMqjBpiSVX8rCoZT1KR7J8G9IYmzZNC0uWjzcmc6rITbqN49mqW%2BQ%3D%3D&up_:up_kind_cd";
//		String url = api_uri.replace(":up_kind_cd", up_kind_cd);
		
		String api_uri = "http://openapi.animal.go.kr/openapi/service/rest/abandonmentPublicSrvc/kind?serviceKey=rFLSToMpG8eKdRK3iDnyv4O1YKfGwXhnS%2FMqjBpiSVX8rCoZT1KR7J8G9IYmzZNC0uWjzcmc6rITbqN49mqW%2BQ%3D%3D&up_kind_cd={}";
		api_uri = api_uri.replace("{}", breedCode);
		
//		String type_dog = "417000";
//		String type_cat = "422400";
		
		Connection con = Jsoup.connect(api_uri);
		con.parser(Parser.xmlParser());

		Document doc;
		
		try {
			doc = con.get();
			Elements elems = doc.select("response body items item");
			PetType pt = new PetType();
			
			for( Element each : elems ) {
				/*
				미디엄 푸들
				000074
				미텔 스피츠
				000080
				믹스견
				000114
				 */
				System.out.println(each.select("KNm").text());
				System.out.println(each.select("kindCd").text());
				pt.setPetName(each.select("KNm").text());
				pt.setPetType(breedType);
				pt.setKindCd(each.select("kindCd").text());
				petDao.insertPetBreeds(pt);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}