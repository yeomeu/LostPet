package gmail.yeomeu.pet.web;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import gmail.yeomeu.pet.dto.LostPet;
import gmail.yeomeu.pet.dto.PetType;
import gmail.yeomeu.pet.dto.User;
import gmail.yeomeu.pet.service.PetService;

@Controller
public class petController {
	
	@Inject
	PetService petService;
	
	@RequestMapping (value="/register/lost", method=RequestMethod.GET)
	public String pageLost() {
		
		return "lost";
	}
	
	@RequestMapping(value="/pettype", method=RequestMethod.GET, produces="application/json;charset=utf-8")
	@ResponseBody
	public Object listPetTypes ( ) {
		List<PetType> types = petService.findPetTypes();
		
		HashMap<String, Ptype> data = new HashMap<>();
		for ( PetType pt : types ) {
			String tname = pt.getPetType();
			Ptype ptypes = data.get(tname); // dog, cat
			if ( ptypes == null) {
				ptypes = new Ptype(tname, new ArrayList<>());
				data.put(tname, ptypes);
			}
			ptypes.types.add(pt.getPetName()); // pt.getPetName()
		}
		
		// data.keySet(); - key 들을 모아서 반환! 
		// data.values(); 값들만 모아서 반환!
		// data.entrySet(); (키,값)의 쌍을 모아서 반환!
		
		Collection<Ptype> result = data.values();
		HashMap<String, Object> res = new HashMap<>();
		res.put("success", true);
		res.put("data", result);
		return res;
	}
	
	@RequestMapping (value="/register/losts", method=RequestMethod.POST, produces="application/json;charset=utf-8")
	@ResponseBody
	public Object doRegister (LostPet lostPet, HttpSession session  ) {
		User loginUser = (User) session.getAttribute("loginUser");
		if ( loginUser == null ) {
			loginUser = new User();
			loginUser.setEmail("ki3m@naver.com");
		}
		lostPet.setOwner(loginUser);
		lostPet.setReward(10000);
		
		petService.registerLostPet ( lostPet );
		
		System.out.println(lostPet.toString()); // dlkfasjldskfjd@30d0393id
		HashMap<String, Object> res = new HashMap<>();
		res.put("success", true);
		
		return res;
	}
	
	@RequestMapping (value="/query/breeds", method=RequestMethod.GET, produces="application/json; charset=utf-8")
	@ResponseBody
	public Object queryBreed ( @RequestParam String keyword) {
		List<String> breeds =  petService.findBreeds(keyword);
		return breeds;
	}

	public static class Ptype {
		/**
		 * @return the name
		 */
		public String getName() {
			return name;
		}
		/**
		 * @return the types
		 */
		public List<String> getTypes() {
			return types;
		}
		public Ptype(String key, List<String> value) {
			name = key;
			types = value;
		}
		String name;
		List<String> types;
		
	}
}