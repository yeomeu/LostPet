package gmail.yeomeu.pet.web;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import gmail.yeomeu.pet.dto.User;
import gmail.yeomeu.pet.service.UserService;

@Controller
public class LoginController {

	@Inject
	UserService userService;
	
	@RequestMapping(value="/login", method=RequestMethod.GET)
	public String pageLogin() {
		return "login";
	}
	
	/*@RequestMapping(value="/login", method=RequestMethod.POST, produces="application/json;charset=utf-8")
	@ResponseBody
	public Object doLogin(User user) {
		
		User loginUser = userService.doLogin(user); // new User("ddd@dd.d", "1111", "333.333.3");
		
		Map<String, Object> res = new HashMap<>();
		if ( loginUser != null) {
			res.put("success", true);
			res.put("user", loginUser);			
		} else {
			res.put("success", false);
			res.put("cause", "INVALID_ACCOUNT");
		}
		
		return res;
	}*/
	
	@RequestMapping(value="/login", method=RequestMethod.POST, produces="application/json;charset=utf-8")
	@ResponseBody
	public Object doLogin (User user, HttpServletRequest req) {
		
		// 사용자 존재여부 체크
		User loginUser = userService.exist (user);
		Map<String, Object> res = new HashMap<>();
		
		if ( loginUser != null) {
			HttpSession session = req.getSession();
			session.setAttribute("loginUser", loginUser);
			
			User aaa = (User) session.getAttribute("loginUser");
			aaa.getEmail();
			
			loginUser = userService.doLogin(user);
			
			if ( loginUser != null ) {
				res.put("success", true);
				res.put("user", loginUser);			
			}
		} else {
			res.put("success", false);
			res.put("cause", "INVALID_ACCOUNT");
		}
		return res;
	}
	@RequestMapping(value="/logout")
	public String logout( HttpSession session) {
		// session.removeAttribute("loginUser");
		session.invalidate();
		return "redirect:/";
	}
}