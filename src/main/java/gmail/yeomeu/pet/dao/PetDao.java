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
		
		int ninsert = session.insert("PetMapper.insertReomtePet", pet) ;
		if ( ninsert != 1 ) {
			// error!???
			System.out.println("ERROR: " + pet);
		}
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
}