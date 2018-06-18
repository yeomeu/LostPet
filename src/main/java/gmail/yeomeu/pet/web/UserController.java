package gmail.yeomeu.pet.web;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import gmail.yeomeu.pet.dao.UserDao;
import gmail.yeomeu.pet.dto.User;
import gmail.yeomeu.pet.service.UserService;

@Controller
public class UserController {

	@Inject
	UserService userService;
	
	@RequestMapping(value="/join", method=RequestMethod.GET)
	public String pageJoin() {
		System.out.println("/join");
		return "join";
	}
	
	@RequestMapping(value="/join/member", method=RequestMethod.POST, produces="application/json;charset=utf-8")
	@ResponseBody
	public Object joinMember(@ModelAttribute User user) throws JsonProcessingException {
		boolean success = userService.join(user);
		if ( success) {
			;
		} else {
			;
		}
		// userDao.join(user);
		System.out.println(user);
		// { success : true }
		Map<String, Object> res = new HashMap<>();
		res.put("success", true);
		res.put("user", user);
		return res;
		// { success : true , user : { email : xxxx, password : 1111} }
//		ObjectMapper om= new ObjectMapper();
//		String json = om.writeValueAsString(om);
//		return json;
//		return "{\"success\": true}"; // var object = { success : true };
		
//		return "join"; // join.jsp
	}
}