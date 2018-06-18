package gmail.yeomeu.pet.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import gmail.yeomeu.pet.dto.LostPet;
import gmail.yeomeu.pet.dto.PetType;

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
}