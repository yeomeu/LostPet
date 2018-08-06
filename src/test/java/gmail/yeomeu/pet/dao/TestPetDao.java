package gmail.yeomeu.pet.dao;

import static org.junit.Assert.*;

import java.util.List;

import javax.inject.Inject;

import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import gmail.yeomeu.pet.dto.RemoteLostPet;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class TestPetDao {

	@Inject PetDao petDao;
	@Test
	@Ignore
	public void test() {
		RemoteLostPet s = new RemoteLostPet();
		s.setDesertionNo(11111L);
		s.setCareAddr("XXXX");
		s.setCareNm("ccc");
		s.setCareTel("000333");
		s.setChargeNm("ggg");
		// s.setAnimalImg("/gggg/ggg.png");
		s.setHappenDt("20180101");
		s.setHappenPlace("soadikfdk");
		s.setKindCd("말라뮤트");
		s.setSexCd("M");
		s.setNoticeSdt("20180202");
		s.setNoticeEdt("20180202");
		s.setNoticeNo("서울-은평-33333");
		s.setOfficeTel("333-333-333");
		petDao.insertRemoteLostPet(s);
	}
	
	@Test
	public void findLostPets () {
		List<RemoteLostPet> pets = petDao.findLostPets("20180701", "dog");
		System.out.println(pets.size());
		for ( RemoteLostPet each : pets) {
			System.out.println( each.toString());
		}
		System.out.println("ok?");
	}

}
