package gmail.yeomeu.pet.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;

import gmail.yeomeu.pet.dao.UserDao;
import gmail.yeomeu.pet.dto.LostPet;
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
	
	@RequestMapping(value="/myinfo", method=RequestMethod.GET)
	public String myinfo() {
		System.out.println("/myinfo");
		return "myinfo";
	}
	@RequestMapping(value="/loadMyInfo", method=RequestMethod.GET, produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Object loadMyInfo(HttpSession session) {
		
		User user = (User) session.getAttribute("loginUser");
		Map<String, Object> res = new HashMap<>();
		if (user != null) {
			res.put("user", user);
			
		}
		return res;
	}
	
	@RequestMapping(value="/member/update", method=RequestMethod.POST, produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Object updatePwd(@RequestParam String curpw, @RequestParam String newpw, HttpSession session) {

		User user = (User) session.getAttribute("loginUser");
		Map<String, Object> res = new HashMap<>();
		if ( curpw.equals(user.getPassword())) {
			userService.updatePassword(user.getEmail(), newpw);
			user.setPassword(newpw);
			res.put("success", true);
		} else {
			res.put("success", false);
			res.put("cause", "INVALID_PW");
		}
		return res;
	}
	
	@RequestMapping(value="/member/mailing", method=RequestMethod.POST, produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Object updateMailing (HttpSession session, @RequestParam String accept, @RequestParam String s ,@RequestParam  String e ){
		
		User user = (User) session.getAttribute("loginUser");
		
		String stime = "Y".equals(accept) ? s : null ;
		String etime = "Y".equals(accept) ? e : null ;
		
		userService.updateMailing(user.getEmail(), stime, etime);
		
		session.setAttribute("loginUser", userService.exist(user) );
		
		Map<String, Object> res = new HashMap<>();
		res.put("success", true);
		return res;
	}
	
	@RequestMapping(value="/mypost", method=RequestMethod.GET, produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Object getMyPost(HttpSession session) {
		
		User user = (User) session.getAttribute("loginUser");
		
		Map<String, Object> res = new HashMap<>();
		if (user != null) {
			String email = user.getEmail(); 
			List<LostPet> lostpet = userService.getMyPost(email);
			res.put("post", lostpet);
			res.put("success", true);
			
			System.out.println(lostpet);
		} else {
			res.put("success", false);
			res.put("cause", "NO_LOGIN");
		}
		return res;
	}
	
	@RequestMapping(value="/member/delete", method=RequestMethod.POST, produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Object memberDelete (@RequestParam String password, HttpSession session) {
		
		User user = (User) session.getAttribute("loginUser");
		Map<String, Object> res = new HashMap<>();

		boolean result = password.equals(user.getPassword());
		
		if ( result ) {
			
			int n = userService.deleteUser (user.getEmail());
			System.out.println("n >>"+n);
			
			if (n == 1) {
				res.put("success", true);
				session.invalidate();
			} else {
				res.put("success", false);
			}
		} else {
			res.put("success", false);
		}
		
		return res;
	}
}