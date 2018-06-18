package gmail.yeomeu.pet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class BreedExtractor {

	public static void main(String[] args) throws IOException {
		// step 1. 견종 목록 확보
		String url = "https://en.wikipedia.org/wiki/List_of_dog_breeds";
		Connection con = Jsoup.connect("https://en.wikipedia.org/wiki/List_of_dog_breeds");
		Document doc = con.get();
//		System.out.println(doc.toString());
		Elements elems = doc.select("table"); // [table, table,, table]
		Element table = elems.get(0);
		Elements tds = table.select("tr > td:first-child > a" );
		/*
		List<String> breedNames = new ArrayList<>();
		for ( Element td : tds ) {
			String breedName = td.text();
			breedNames.add(breedName);
		}
		*/
		List<String> breedNames = tds.eachText();
//		System.out.println(breedNames.toString());
		
		// step 2. 한글로 번역
//		List<String> ten = breedNames.subList(10, 20);
		List<String> korNames = translate ( breedNames );
		System.out.println(korNames);
		
		// step 3. 쿼리문 출력
		String q = "INSERT INTO pets ( pet_name, pet_type) values ( ':1', 'dog');";
		for (String ko : korNames) {
			String query = q.replace(":1", ko);
			System.out.println(query);
		}
		
	}

	private static List<String> translate(List<String> breedNames) throws IOException {
		String clientId = "EEmNqmCom9nFi1JI6bjm";
		String clientSecret = "lFopWin5q5";

		List<String> koNames = new ArrayList<>();
		int cnt = 0;
		for ( String engName : breedNames ) {
			Connection con = Jsoup.connect("https://openapi.naver.com/v1/papago/n2mt");
			con.timeout(120*1000);
			con.header("X-Naver-Client-Id", clientId);
			con.header("X-Naver-Client-Secret", clientSecret);
			con.data("source", "en");
			con.data("target", "ko");
			con.data("text", engName);
			con.ignoreContentType(true);
			Document doc = con.post();
			String json = doc.select("html > body").text();
			int p0 = json.lastIndexOf(':');
			int p1 = json.indexOf('"', p0); // p1+1
			int p2 = json.lastIndexOf('"');
			p2 = json.indexOf('"', p1+1);
			String ko = json.substring(p1+1, p2);
			
			koNames.add(ko);
			System.out.printf("[%d/%d] translated : %s\n", (++cnt) , breedNames.size(), ko);
			
			try {
				Thread.sleep(500);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
			
		}
		return koNames;
	}
	
	

}
