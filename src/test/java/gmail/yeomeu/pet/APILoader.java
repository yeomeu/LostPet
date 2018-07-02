package gmail.yeomeu.pet;

import java.io.IOException;

import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.parser.Parser;

import gmail.yeomeu.pet.service.PetService;

/**
 * 
 http://openapi.animal.go.kr/openapi/service/rest/
 
 abandonmentPublicSrvc/abandonmentPublic?
 
 serviceKey=LX%2Bvip8U1cIkZRIYLe%2Fj20f%2F7QAGPO8I3bIF6PRU9ILI05ynseP670tj5oAmkfnaUDKKbMPLRuQNRdosbKDN%2Fg%3D%3D
 &bgnde=20180601&
 endde=20180630&
 upkind=417000&
 state=notice&
 pageNo=1&
 startPage=1&
 numOfRows=50&
 pageSize=50&
 neuter_yn=N
 * @author yeom
 *
 */
public class APILoader {
	static String api_uri = "http://openapi.animal.go.kr/openapi/service/rest/abandonmentPublicSrvc/abandonmentPublic?serviceKey=LX%2Bvip8U1cIkZRIYLe%2Fj20f%2F7QAGPO8I3bIF6PRU9ILI05ynseP670tj5oAmkfnaUDKKbMPLRuQNRdosbKDN%2Fg%3D%3D&bgnde=:sd&endde=:ed&pageNo=1&startPage=1&numOfRows=500&pageSize=50&neuter_yn=Y";
	//                       http://openapi.animal.go.kr/openapi/service/rest/abandonmentPublicSrvc/abandonmentPublic?serviceKey=LX%2Bvip8U1cIkZRIYLe%2Fj20f%2F7QAGPO8I3bIF6PRU9ILI05ynseP670tj5oAmkfnaUDKKbMPLRuQNRdosbKDN%2Fg%3D%3D&bgnde=20180601&endde=20180630&upkind=417000&state=notice&pageNo=1&startPage=1&numOfRows=50&pageSize=50&neuter_yn=Y
	static String type_dog = "417000";
	static String type_cat = "422400";
	static String type_etc = "429900";
	public static void main(String[] args) throws IOException {
		/*
		String start = "20180501";
		String end = "20180531";
		String url = api_uri.replace(":sd", start)
				            .replaceAll(":ed", end)
				            .replaceAll(":breed",  type_dog);
		
		System.out.println(url);
		
		
		Connection con = Jsoup.connect(url);
		con.parser(Parser.xmlParser());

		Document doc = con.get();
		System.out.println(doc.toString());
		
		// System.out.println( doc.select("response header resultMsg").toString());
		*/
		PetService ps = new PetService();
		// ps.setPetDao ( new PetDao());
		ps.doLoadData("20180501", "20180501");
		
		// java reflection
		
		// PetService.class.getField(")
		
/*
	<age>2013(년생)</age>
<desertionNo>442424201800073</desertionNo> PK 
<careAddr>강원도 삼척시 척주로 131 (정상동, 밀레니엄세탁) </careAddr>
<careNm>삼척시유기동물보호소</careNm>
<careTel>010-9492-4912</careTel>
<chargeNm>삼척시</chargeNm>
<filename>http://www.animal.go.kr/files/shelter/2018/06/201806211006766_s.jpg</filename>
<happenDt>20180615</happenDt>  2018-04-10
<happenPlace>등봉동 산길</happenPlace>
<kindCd>[개] 푸들</kindCd>	
<sexCd>M</sexCd>
<noticeSdt>20180621</noticeSdt>
<noticeEdt>20180702</noticeEdt>
<noticeNo>강원-삼척-2018-00077</noticeNo>
<officetel>033-570-3863</officetel>
<orgNm>강원도 삼척시</orgNm>
	<neuterYn>Y</neuterYn>
	<colorCd>갈색</colorCd>
*/
	}
}