package gmail.yeomeu.pet;

import static org.junit.Assert.*;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import gmail.yeomeu.pet.dto.User;
import gmail.yeomeu.pet.service.MailService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class TestMailSender {

	@Inject
	MailService mailService;
	
	@Test
	public void test() {
		// assertNotNull ( mailService);
		User user = new User();
		user.setEmail("yeomeu@gmail.com");
		mailService.sendMail(user, "TEST Mail!!!!", "html 그대로 나옴! <b>this is test mail</b>. YES!");
	}

}
