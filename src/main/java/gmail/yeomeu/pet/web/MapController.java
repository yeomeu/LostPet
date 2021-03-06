package gmail.yeomeu.pet.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import gmail.yeomeu.pet.dto.LostPet;
import gmail.yeomeu.pet.dto.RemoteLostPet;
import gmail.yeomeu.pet.service.FileService;
import gmail.yeomeu.pet.service.PetService;

@Controller
public class MapController {

	private @Value("${daummap.key}") String mapKey;

	@Inject
	PetService petService;
	LostPet lostPet;
	
	@Inject FileService fileService;
	
	@RequestMapping (value="/lostMap", method=RequestMethod.GET)
	public String pageLost() {
		
		return "lostMap";
	}
	
	@RequestMapping (value="/petmap", method=RequestMethod.GET)
	public String pagePetMap ( Model model) {
		model.addAttribute("daumMapKey", mapKey);
		return "petmap";
	}
	
	@RequestMapping (value="/petdata", method=RequestMethod.GET, produces=MediaType.APPLICATION_JSON_UTF8_VALUE )
	@ResponseBody
	public Object petData (@RequestParam String since, @RequestParam(required=false) String petType) {
		
		List<RemoteLostPet> pets = petService.findLostPets(since.replaceAll("-", ""), petType); // YYYY-MM-DD
		Map<String, Object> res = new HashMap<>();
		res.put("success", true);
		res.put("data", pets);
		return res;
	}
	
	@RequestMapping (value="/lostList", method=RequestMethod.GET, produces="application/json;charset=utf-8")
	@ResponseBody
	public Object lostList () {
		
		HashMap<String, Object> res = new HashMap<>();
		
		List<LostPet> lostPet = petService.findLostList();
		res.put("lostList", lostPet);
		res.put("success", true);
		return res;
	}
	
	@RequestMapping (value="/lostpet/pics/{uniqueFile}", method=RequestMethod.GET, produces="image/*")
	@ResponseBody
	public byte[] viewPicture (@PathVariable String uniqueFile, HttpServletResponse res) {
		// ${rootDir}eqwffds-3asdf-3wq3fsadf 
		// res.setContentType("image/png"); ///
		byte [] imagedata = fileService.read(uniqueFile);
		return imagedata;
	}
	
	@RequestMapping (value="/pics/{lostpet}", method=RequestMethod.GET, produces="application/json;charset=utf-8")
	@ResponseBody
	public Object getPictures(@PathVariable Integer lostpet){
		/*
		 *    39238u3-23j4-34hj894
		 *    df873h3-23jf94-34rj4-
		 */
		List<String> links = petService.getPictureLink(lostpet );
		
		// /lostpet/pics", 
		return links ;
		
	}
}