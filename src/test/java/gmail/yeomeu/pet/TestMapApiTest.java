package gmail.yeomeu.pet;

import static org.junit.Assert.*;

import java.util.Arrays;

import org.junit.Test;

import gmail.yeomeu.pet.service.MapApiService;

public class TestMapApiTest {

	@Test
	public void test() {
		MapApiService apiService = new MapApiService();
		
		double [] pos = apiService.findCoord("전라북도 전주시 완산구 경원동1가");
		System.out.println(Arrays.toString(pos));
		
	}

}
