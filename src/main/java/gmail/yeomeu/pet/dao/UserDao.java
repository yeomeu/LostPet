package gmail.yeomeu.pet.dao;

import java.util.HashMap;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import gmail.yeomeu.pet.dto.User;

@Repository
public class UserDao {
	
	@Inject
	SqlSession session;
	
	public void join ( User user ) {
		session.insert("UserMapper.insertUser", user);
	}

	public User doLogin(User user) {
		User loginUser = session.selectOne("UserMapper.login", user);
		return loginUser;
	}

	public User exist(User user) {
		User loginUser = session.selectOne("UserMapper.exist", user);
		return loginUser;
	}

	public void updatePassword(String email, String newpw) {
		HashMap<String, String> param = new HashMap<>();
		param.put("email", email);
		param.put("newpw", newpw);
		session.update("UserMapper.updatePassword", param);
	}

	public int deleteUser(String email) {
		return session.delete("UserMapper.deleteUser", email);
	}
}
