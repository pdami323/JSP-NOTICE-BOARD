package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

//데이터베이스 접근 객체로서 데이터베이스에서 정보를 불러오거나 값을 저장하는 역할
public class UserDAO {
	
	private Connection conn;	//데이터베이스에 접근하게 해주는 객체
	private PreparedStatement pstat;
	private ResultSet rs;
	
	public UserDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/BBS?serverTimezone=UTC";	//3306포트는 mysql 서버 
			String dbID = "root";
			String dbPassword = "ekal0323";
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public int login(String userID, String userPassword) {
		String SQL = "SELECT userPassword FROM USER WHERE userID = ?";
		try {
			pstat = conn.prepareStatement(SQL);	
			pstat.setString(1, userID);		//SQL에 ?대신에 매개변수로서 userID를 넣어줌으로써 해킹을 방지
			rs = pstat.executeQuery();		//SQL 실행 결과 
			if(rs.next()) {					//실행 결과가 존재한다면
				if(rs.getString(1).equals(userPassword)) {		//비밀번호 확인
					return 1;	//로그인 성공
				}
				else
					return 0;		//비밀번호 불일치
			}
			return -1;						//결과값이 없다면, 즉 회원이 없는 경우
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -2;	//데이터베이스 오류를 의미
	}
	public int join(User user) {
		String SQL = "INSERT INTO USER VALUES (?, ?, ?, ?, ?)";
		try {
			pstat = conn.prepareStatement(SQL);
			pstat.setString(1, user.getUserID());
			pstat.setString(2, user.getUserPassword());
			pstat.setString(3, user.getUserName());
			pstat.setString(4, user.getUserGender());
			pstat.setString(5, user.getUserEmail());
			return pstat.executeUpdate();		//반드시 0 이상의 숫자가 반환
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
}
