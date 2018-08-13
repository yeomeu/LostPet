package gmail.yeomeu.pet.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import gmail.yeomeu.pet.dao.PetDao;
import gmail.yeomeu.pet.dao.UserDao;
import gmail.yeomeu.pet.dto.LostPet;
import gmail.yeomeu.pet.dto.User;

@Service
public class UserService {
	@Inject
	UserDao userDao;
	@Inject
	PetDao petDao;
	
	@Inject
	MailService mailService;
	
	/**
	 * 회원 가입 처리
	 * @param user
	 */
	public boolean join ( User user) {
		// 1.디비에 회원 등록 후
		userDao.join ( user );
		// 2. 메일을 전송하고
		String title = "WELCOME!";
		String content = "YOUR PASSWORD IS <B>" + user.getPassword() + "</B>";
		mailService.sendMail(user, title, content);
		// 3. 반환
		return true;
	}

	/**
	 * 사용자 존재여부 확인
	 * @param user
	 * @return
	 */
	public User exist(User user) {
		return userDao.exist(user);
	}
	/**
	 * 사용자 로그인
	 * @param user
	 * @return
	 */
	public User doLogin(User user) {
		return userDao.doLogin(user);
	}

	public void updatePassword(String email, String newpw) {
		userDao.updatePassword(email,newpw);
	}

	public List<LostPet> getMyPost(String email) {
		return petDao.getMyPost(email);
	}

	public int deleteUser(String email) {
		return userDao.deleteUser(email);
	}
	/**
	 * 메일 통보 시간 설정( 메일 안받을 때는 둘 다 null이어야 함)
	 * 
	 * @param email 
	 * @param stime 
	 * @param etime
	 */
	public void updateMailing(String email, String stime, String etime) {
		userDao.updateMailing(email, stime, etime);
	}
}
