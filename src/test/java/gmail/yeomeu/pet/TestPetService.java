package gmail.yeomeu.pet;

import static org.junit.Assert.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import gmail.yeomeu.pet.dto.RemoteLostPet;
import gmail.yeomeu.pet.service.PetService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class TestPetService {

	@Inject PetService petService;
	@Test
	public void test() {
		Map<String, List<RemoteLostPet>> breedMap = new HashMap<>();
		List<RemoteLostPet> chiwawa = new ArrayList<>();
		chiwawa.add(pet("시츄", "2018-08-01", "인천보호소"));
		chiwawa.add(pet("시츄", "2018-08-01", "경기보호소"));
		breedMap.put("시츄", chiwawa);
		
		petService.startMatching(breedMap);
	}
	private RemoteLostPet pet(String breed, String time, String care) {
		RemoteLostPet p = new RemoteLostPet();
		p.setKindCd(breed);
		p.setHappenDt(time);
		p.setCareNm(care);
		return p;
	}

}
