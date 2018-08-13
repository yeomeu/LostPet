package gmail.yeomeu.pet.service;

import static org.junit.Assert.*;

import java.util.Arrays;
import java.util.List;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.thymeleaf.ITemplateEngine;
import org.thymeleaf.context.Context;

import gmail.yeomeu.pet.dto.User;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class TestMailing {

	@Inject ITemplateEngine engine;
	
	@Test
	public void test() {
		
		assertNotNull ( engine);
		
		User user = new User("aaa.abc.com", "", "");
		
		List<String> pics = Arrays.asList(
				"http://www.animal.go.kr/files/shelter/2018/07/201807251307602.jpg", 
				"http://www.animal.go.kr/files/shelter/2018/07/201807251307602.jpg");
		
		Context ctx = new Context(); // HttpServetRequest  req.getAttribute("", "");
		ctx.setVariable("user", user);
		ctx.setVariable("pics", pics); // req.setAttribute("", "");
		
		String content = engine.process("lost-pets", ctx);
		
		System.out.println("=====");
		System.out.println(content);
		System.out.println("=====");
	}

}
