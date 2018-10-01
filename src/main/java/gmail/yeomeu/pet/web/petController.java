package gmail.yeomeu.pet.web;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import gmail.yeomeu.pet.dto.LostPet;
import gmail.yeomeu.pet.dto.PetType;
import gmail.yeomeu.pet.dto.RemoteLostPet;
import gmail.yeomeu.pet.dto.User;
import gmail.yeomeu.pet.service.PetService;

@Controller
public class petController {
	
	private @Value("${daummap.key}") String mapKey;
	
	@Inject
	PetService petService;
	
	@RequestMapping (value="/register/lost", method=RequestMethod.GET)
	public String pageLost( Model model) {
		model.addAttribute("daumMapKey", mapKey);
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

	@RequestMapping (value="/shelter/{tel}", method=RequestMethod.GET, produces="application/json; charset=utf-8")
	public String getShelter ( @PathVariable String tel, Model model) {
		Map<String, Object>  shelter = petService.getShelter(tel);
		model.addAttribute("shelter", shelter);
		
		/* N : 234
		 * L : 10
		 *     24page
		 * N / L + ( N % L > 0 ? 1 : 0 )
		 */
		int total = petService.countPets(tel);
		int pageLen = 10;
		int totalPage = total/pageLen + ( total % pageLen > 0 ? 1 : 0 );
		model.addAttribute("totalPage", totalPage);
		
		/* PS : 6
		 *  B : 5
		 *  
		 * PS / B + ( PS % B > 0 ? 1 : 0 )
		 */
		
		model.addAttribute("navStart", 0);
		model.addAttribute("navEnd", 4);
		// req.setAttribute("shelter", shelter);
		return "shelter" ;
	}
	
	// /pet/shelter/041-356-8210/pets/1
	@RequestMapping (value="/shelter/{tel}/pets/{page}", method=RequestMethod.GET, produces="application/json; charset=utf-8")
	@ResponseBody
	public Object findPetsByShelter (@PathVariable String tel, @PathVariable Integer page) {
		
		int total = petService.countPets(tel);
		int pageLen = 10;
		int totalPage = total/pageLen + ( total % pageLen > 0 ? 1 : 0 );
		
		int boxLen = 5;
		int navSize = totalPage / boxLen + ( totalPage % boxLen > 0 ? 1 : 0); // 6
		System.out.println("total nav : " + navSize);
		// 30 , 5 = 6
		// [ 1, 2, 3, 4]
		// [ 5, 6]
		// page 에서 보여질 게시물 리스트의 범위
		List <RemoteLostPet> pets = petService.findPetsByShelter(tel, page);
		
		// page : 68
		// boxLen : 10
		// box area 구간 결정
		int boxIndex = (page-1) / boxLen;  // 1
		int boxStart = boxIndex * boxLen; // 4
		int boxEnd = boxStart + boxLen;   // 8
		
		HashMap<String, Object> res = new HashMap<>();
		res.put("navstart", boxStart+1);
		res.put("navend", Math.min(totalPage, boxEnd) );
		res.put("totalPage", totalPage);
		res.put("pets", pets);
		return res;
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