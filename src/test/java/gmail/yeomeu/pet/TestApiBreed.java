package gmail.yeomeu.pet;

import java.io.IOException;

import javax.inject.Inject;

import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.parser.Parser;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import gmail.yeomeu.pet.service.PetService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class TestApiBreed {
	
	static String api_uri = "http://openapi.animal.go.kr/openapi/service/rest/abandonmentPublicSrvc/kind?serviceKey=rFLSToMpG8eKdRK3iDnyv4O1YKfGwXhnS%2FMqjBpiSVX8rCoZT1KR7J8G9IYmzZNC0uWjzcmc6rITbqN49mqW%2BQ%3D%3D&up_kind_cd=417000";
	static String type_dog = "417000";
	static String type_cat = "422400";
	
	@Inject
	PetService ps;
	
	@Test
	public void test() throws IOException {
		
		/*
		String url = api_uri.replaceAll(":breed",  type_dog);
		
		System.out.println(url);
		
		Connection con = Jsoup.connect(url);
		con.parser(Parser.xmlParser());

		Document doc = con.get();
		System.out.println(doc.toString());
		
		System.out.println( doc.select("response header resultMsg").toString());
		
		*/
		
		// PetService ps = new PetService();
		ps.getPetBreed("429900", "etc");
	}
}