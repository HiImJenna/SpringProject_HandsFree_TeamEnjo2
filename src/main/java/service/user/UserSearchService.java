package service.user;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.user.UserSearchDao;

@Service
public class UserSearchService {
	@Autowired
	private SqlSession sqlsession;
	
	
	public List<Map<String, String>> getStore(String latitude, String longitude){
		List<Map<String, String>> list = null;
		Map map=null;
		try {
			UserSearchDao userSearchDao = sqlsession.getMapper(UserSearchDao.class);
			list = userSearchDao.selectStore(latitude, longitude);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}


}