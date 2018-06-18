package gmail.yeomeu.pet.web;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import gmail.yeomeu.pet.dto.LostPet;
import gmail.yeomeu.pet.service.PetService;

@Controller
public class MapController {

	@Inject
	PetService petService;
	LostPet lostPet;
	
	@RequestMapping (value="/lostMap", method=RequestMethod.GET)
	public String pageLost() {
		
		return "lostMap";
	}
	
	@RequestMapping (value="/lostList", method=RequestMethod.GET, produces="application/json;charset=utf-8")
	@ResponseBody
	public Object lostList () {
		
		System.out.println("-----lostList");
		HashMap<String, Object> res = new HashMap<>();
		
		List<LostPet> lostPet = petService.findLostList();
		res.put("lostList", lostPet);
		res.put("success", true);
		return res;
	}
}