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
		String api_uri = "http://openapi.animal.go.kr/openapi/service/rest/abandonmentPublicSrvc/abandonmentPublic?serviceKey=LX%2Bvip8U1cIkZRIYLe%2Fj20f%2F7QAGPO8I3bIF6PRU9ILI05ynseP670tj5oAmkfnaUDKKbMPLRuQNRdosbKDN%2Fg%3D%3D&bgnde=:sd&endde=:ed&pageNo=1&startPage=1&numOfRows=500&pageSize=50&neuter_yn=Y";
		String url = api_uri.replace(":sd", start)
				            .replaceAll(":ed", end);
		Connection con = Jsoup.connect(url);
		con.parser(Parser.xmlParser());

		Document doc;
		try {
			doc = con.timeout(60*1000).get();
			Elements elems = doc.select("response body items item");
			
			List<RemoteLostPet> list = new ArrayList<>();
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
				pet.setKindCd(each.select("kindCd").text()); // FIXME 무조건 밀어넣으며 안되고, 견종 테이블에 있는지 확인하고 넣어야 함 그리고 앞에 [개], [고양이] 떼어내야함
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
				
				System.out.println("desertionNo --->"+Long.parseLong(each.select("desertionNo").text()));
				System.out.println("officeTel   --->"+each.select("officeTel").text());
				
				petDao.insertRemoteLostPet(pet);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		// System.out.println(doc.toString());
		
	}

	public List<RemoteLostPet> findLostPets(String since) {
		return petDao.findLostPets( since );
	}
}