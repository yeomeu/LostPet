package gmail.yeomeu.pet.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import gmail.yeomeu.pet.dao.UserDao;
import gmail.yeomeu.pet.dto.User;

@Service
public class UserService {
	@Inject
	UserDao userDao;
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
}
