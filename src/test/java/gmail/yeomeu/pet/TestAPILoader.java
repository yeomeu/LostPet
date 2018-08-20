package gmail.yeomeu.pet;

import static org.junit.Assert.*;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import gmail.yeomeu.pet.service.PetService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class TestAPILoader {

	@Inject
	PetService ps;
	
	@Test
	public void test() {
//		PetService ps = new PetService();
//		ps.setPetDao ( new PetDao());
		ps.doLoadData("20180724", "20180724");
	}
}
