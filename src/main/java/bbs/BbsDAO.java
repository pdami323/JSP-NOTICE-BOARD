package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbsDAO {
	private Connection conn;	//데이터베이스에 접근하게 해주는 객체
	private ResultSet rs;
	
	public BbsDAO() {
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
	
	public String getDate() {
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstat = conn.prepareStatement(SQL);
			rs = pstat.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "";	//데이터베이스 오류
	}
	
	public int getNext() {	//다음에 쓰일 게시물 번호
		String SQL = "SELECT bbsID FROM BBS ORDER BY bbsID DESC";
		try {
			PreparedStatement pstat = conn.prepareStatement(SQL);
			rs = pstat.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; //첫번째 게시물인 경우
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;	//데이터베이스 오류
	}
	
	public int write(String bbsTitle, String userID, String bbsContent) {
		String SQL = "INSERT INTO BBS VALUES(?,?,?,?,?,?)";
		try {
			PreparedStatement pstat = conn.prepareStatement(SQL);
			pstat.setInt(1, getNext());
			pstat.setString(2, bbsTitle);
			pstat.setString(3, userID);
			pstat.setString(4, getDate());
			pstat.setString(5, bbsContent);
			pstat.setInt(6, 1);		//available로서 삭제여부
			return pstat.executeUpdate();	//insert의 경우 성공했을 때 0 이상의 숫자를 반환
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;	//데이터베이스 오류
	}
	
	public ArrayList<Bbs> getList(int pageNumber){
		String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10";
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		try {
			PreparedStatement pstat = conn.prepareStatement(SQL);
			pstat.setInt(1, getNext() - (pageNumber-1)*10);
			rs = pstat.executeQuery();
			while(rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				list.add(bbs);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public boolean nextPage(int pageNumber) {	//글의 수가 10단위인 경우 nextpage 버튼이 없어야 하므로 
		String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1";
		try {
			PreparedStatement pstat = conn.prepareStatement(SQL);
			pstat.setInt(1, getNext() - (pageNumber-1)*10);
			rs = pstat.executeQuery();
			if(rs.next()) {	//다음 페이지가 있는 경우
				return true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
}
