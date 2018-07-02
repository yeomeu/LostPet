package gmail.yeomeu.pet.service;

import java.io.IOException;

import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.parser.Parser;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Service;

@Service
public class MapApiService {

	public double [] findCoord (String addr) {
		
		String url = "https://dapi.kakao.com/v2/local/search/address.xml";
		
		Connection con = Jsoup.connect(url);
		con.header("Host",  "dapi.kakao.com");
		con.header("Authorization", "KakaoAK " + "13674c955cca22785e17796fbfd0d5ca");
		
		con.data("query", addr);
		con.data("size", "30");
		con.parser(Parser.xmlParser());
		
		try {
			Document doc = con.get();
			// System.out.println(doc.toString());
			
			Elements el = doc.select("result documents"); // el 이 없을 ㅅ도 있음 
			
			if (el.size() != 0) {
				Element e = el.get(0);
				String slat = e.select("> y").text();
				String slng = e.select("> x").text();
				
				return new double[] { 
						Double.parseDouble(slat), 
						Double.parseDouble(slng)} ;
			} else {
				// [ null ,null ]
				// [ 0, 0]
				System.out.println("no pos for address : " + addr);
				return new double [] { 0, 0 };
//				 return new Double [] {null, null };
//				return null;
			}
		} catch (IOException e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
		
		
		
	}
}
