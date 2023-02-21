package service.user;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.user.UserMyinfoDao;
import vo.UserReservationJoinVo;
import vo.user.Users;

@Service
public class UserMyinfoService {
	
	// 임시 사라질 수 있음
	private final String PATH = "/files/upload";

	@Autowired
	private SqlSession sqlsession;

	//내 정보 상세보기 서비스
	public Users userDetail(String userid) {
		Users users = null;
		try {
			 	UserMyinfoDao userdao = sqlsession.getMapper(UserMyinfoDao.class);
			 	users = userdao.userDetail(userid);
		} catch (ClassNotFoundException e) {
						e.printStackTrace();
		} catch (SQLException e) {
						e.printStackTrace();
		}
		return users;		
	}

	// 내 정보 수정하기 서비스
	public int userUpdate(Users users) { //userid 잘 넘어옴
		int result = 0;
		try {

			UserMyinfoDao usermyinfodao = sqlsession.getMapper(UserMyinfoDao.class);

			result = usermyinfodao.userUpdate(users);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	// 내 정보 삭제하기 서비스	
	public int userDelete(String userid) {
		int result = 0;
		UserMyinfoDao usermyinfodao = sqlsession.getMapper(UserMyinfoDao.class);
		try {
			result = usermyinfodao.userDelete(userid);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		return result;
		
	}

	// 내 정보 수정하기 처리 서비스
//	public void noticeUpdate(Users users) {
//		if (!users.getProfile_path().equals("")) {
//			String fpath = users.getRealFilePath();
//			FileOutputStream fs = null;
//			try {
//				
//				File dir = new File(users.getRealFilePath());
//				if (!dir.isDirectory()) {
//					dir.mkdir();
//				}
//				
//				fs = new FileOutputStream(fpath + users.getProfile_path().getOriginalFilename());
//				fs.write(users.getProfile_path().getBytes());
//			} catch (Exception e) {
//				e.printStackTrace();
//			} finally {
//				try {
//					fs.close();
//				} catch (Exception e2) {
//					e2.printStackTrace();
//				}
//			}
//		}
//	}
	
	// 파일 다운로드 서비스 함수 -> 다운로드까지 할 지 말 지 물어보기
	public void download(String p, String f, HttpServletRequest request, HttpServletResponse response)
			throws IOException {

		String fname = new String(f.getBytes("euc-kr"), "8859_1");
		response.setHeader("Content-Disposition", "attachment;filename=" + fname + ";");

		String fullpath = request.getServletContext().getRealPath("/customer/" + p + "/" + f);
		FileInputStream fin = new FileInputStream(fullpath);

		ServletOutputStream sout = response.getOutputStream();
		byte[] buf = new byte[1024]; // 전체를 다읽지 않고 1204byte씩 읽어서
		int size = 0;
		while ((size = fin.read(buf, 0, buf.length)) != -1) {
			sout.write(buf, 0, size);
		}
		fin.close();
		sout.close();
	}

	// 사용자 예약 내역 가져오기
	public List<UserReservationJoinVo> getReservationList(String userId) {
		UserMyinfoDao dao = sqlsession.getMapper(UserMyinfoDao.class);
		return dao.getMyReservationList(userId);
	}

}
