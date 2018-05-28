package gmail.yeomeu.pet.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class UserController {

	@RequestMapping(value="/join", method=RequestMethod.GET)
	public String pageJoin() {
		return "join";
	}
	
	@RequestMapping(value="/login", method=RequestMethod.GET)
	public String pageLogin() {
		return "login";
	}
	
}
