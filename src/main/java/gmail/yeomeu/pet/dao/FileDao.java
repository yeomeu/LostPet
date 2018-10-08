package gmail.yeomeu.pet.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class FileDao {

	@Inject
	SqlSession session;
	
	public void insert(Integer lostSeq, String originName, String uniqueName, long fileSize) {
		Map<String, Object> param = new HashMap<>();
		param.put("lostseq", lostSeq);
		param.put("originName", originName);
		param.put("uniqueName", uniqueName);
		param.put("size", fileSize);
		
		session.insert("FileMapper.insert", param);
	}

	public List<String> getPictureLink(Integer lostpet) {
		return session.selectList("FileMapper.getPictureLink", lostpet);
	}

}
