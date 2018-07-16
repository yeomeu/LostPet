package gmail.yeomeu.pet.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.parser.Parser;
import org.jsoup.select.Elements;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import gmail.yeomeu.pet.Util;
import gmail.yeomeu.pet.dao.PetDao;
import gmail.yeomeu.pet.dto.LostPet;
import gmail.yeomeu.pet.dto.PetType;
import gmail.yeomeu.pet.dto.RemoteLostPet;
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

	public void doLoadData(String start, String end) {
		String api_uri = "http://openapi.animal.go.kr/openapi/service/rest/abandonmentPublicSrvc/abandonmentPublic?serviceKey=LX%2Bvip8U1cIkZRIYLe%2Fj20f%2F7QAGPO8I3bIF6PRU9ILI05ynseP670tj5oAmkfnaUDKKbMPLRuQNRdosbKDN%2Fg%3D%3D&bgnde=:sd&endde=:ed&pageNo=1&startPage=1&numOfRows=999&pageSize=50";
		String url = api_uri.replace(":sd", start)
				            .replaceAll(":ed", end);
		Connection con = Jsoup.connect(url);
		con.parser(Parser.xmlParser());

		Document doc;
		try {
			
			doc = con.timeout(60*1000).get();
			Elements elems = doc.select("response body items item");
			RemoteLostPet pet = new RemoteLostPet();
			
			for( Element each : elems ) {
				
				// 1. each => LostPetInfo 
				// 2. inser to db
				
				pet.setDesertionNo(Long.parseLong(each.select("desertionNo").text()));
				pet.setCareAddr(each.select("careAddr").text());
				pet.setCareNm(each.select("careNm").text());
				pet.setCareTel(each.select("careTel").text());
				pet.setChargeNm(each.select("chargeNm").text());
				pet.setAnimalImg(each.select("animalImg").text());
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
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		// System.out.println(doc.toString());
		
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