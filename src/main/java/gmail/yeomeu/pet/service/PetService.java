package gmail.yeomeu.pet.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import gmail.yeomeu.pet.dao.PetDao;
import gmail.yeomeu.pet.dto.LostPet;
import gmail.yeomeu.pet.dto.PetType;

@Service
public class PetService {

	@Inject
	PetDao petDao;
	
	public List<PetType> findPetTypes () {
		return petDao.findPetTypes();
	}

	public void registerLostPet(LostPet lostPet) {
		petDao.insertLostPet ( lostPet );
	}

	public List<LostPet> findLostList() {
		List<LostPet> lostPet = petDao.findLostList();
		return lostPet;
	}
}