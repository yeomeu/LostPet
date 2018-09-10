package gmail.yeomeu.pet.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import gmail.yeomeu.pet.dto.LostPet;
import gmail.yeomeu.pet.dto.PetType;
import gmail.yeomeu.pet.dto.RemoteLostPet;

@Repository
public class PetDao {

	@Inject
	SqlSession session;
	
	public List<PetType> findPetTypes () {
		List<PetType> petType = session.selectList("PetMapper.findPetTypes");
		return petType;
	}

	public void insertLostPet(LostPet lostPet) {
		session.insert("PetMapper.insertLostPet", lostPet);
	}

	public List<LostPet> findLostList() {
		List<LostPet> lostPet = session.selectList("PetMapper.findLostList");
		return lostPet;
	}

	public List<String> findBreeds(String keyword) {
		List<String> breeds = session.selectList("PetMapper.findBreeds", keyword);
		return breeds;
	}
	
	public void insertRemoteLostPet ( RemoteLostPet pet ) {
		
		if ( existPet( pet ) ) {
			// 있으면 상태만 변경함
			int nupdate = session.update("PetMapper.updateRemotePet", pet);
		} else {
			// 없으면 아래 로직대로
			int ninsert = session.insert("PetMapper.insertReomtePet", pet) ;
			if ( ninsert != 1 ) {
				// error!???
				System.out.println("ERROR: " + pet);
			}
			
		}
	}

	private boolean existPet(RemoteLostPet pet) {
		// 450650201804372
		List<RemoteLostPet> pets = session.selectList("PetMapper.existPet", pet.getDesertionNo());
		if (pets.size() > 0) {
			return true;
		} else {
			return false;
		}
		// return pets.size() > 0;
	}

	public List<RemoteLostPet> findLostPets(String since, String petType) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("since", since);
		param.put("petType", petType);
		
		List<RemoteLostPet> pets = session.selectList("PetMapper.findLostPets", param);
		return pets;
	}
	
	public void insertPetBreeds (PetType pt) {
		int ninsert = session.insert("PetMapper.insertPetBreeds", pt);
		if ( ninsert != 1 ) {
			System.out.println("ERROR: " + pt);
		}
	}

	public List<LostPet> getMyPost(String email) {
		return session.selectList("PetMapper.getMyPost", email);
	}
	
	public List<LostPet> findMatchingPets (String kindCd, String date ) {
		return session.selectList("PetMapper.findMatchingPets", kindCd);
	}

	public Map<String, Object> getShelter(String tel) {
		return session.selectOne("PetMapper.getShelter", tel);
	}

	public List<RemoteLostPet> findPetsByShelter(String tel, int offset, int size) {
		Map<String, Object> param = new HashMap<>();
		param.put("tel", tel);
		param.put("offset", offset);
		param.put("size", size);
		
		List<RemoteLostPet> pets= session.selectList("PetMapper.findPetsByShelter", param);
		
		return pets;
	}
}