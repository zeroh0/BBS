package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Date;

public class BbsDAO {
	private Connection conn;
    private ResultSet rs;

    // 생성자 하나의 객체를 만들었을때 자동으로 Connection이 되도록
    public BbsDAO() {
        try {
            String dbURL = "jdbc:oracle:thin:@localhost:1521:xe";
            String dbID = "BBS";
            String dbPassword = "oracle";
            Class.forName("oracle.jdbc.driver.OracleDriver"); //mysql에 접속할 수 있도록 매개체 역할을 하는 라이브러리
            conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
   
     //현재 시간을 가져오는 메소드
    public Date getDate() {
        String sql = "select sysdate from DUAL";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getDate(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null; //데이터베이스 오류
    }
    

    // 다음 게시글 번호: 마지막에 작성된 게시글 번호 + 1 
    public int getNext() {
        String sql = "select bbsID from BBS order by bbsID";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) + 1;
            }
            return 1; //현재 쓰여진 글이 없는 경우 -> 첫번째 게시물
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; // 데이터베이스 오류
    }
    

    // 글 작성 
    public int write(String bbsTitle, String userID, String bbsContent) {
        String sql = "insert into BBS values (?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, getNext());
            pstmt.setString(2, bbsTitle);
            pstmt.setString(3, userID);
            pstmt.setDate(4, getDate());
            pstmt.setString(5, bbsContent);
            pstmt.setInt(6, 1);
            return pstmt.executeUpdate(); // 성공적으로 수행 -> 0이상 값 return
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; // 데이터베이스 오류
    }
}
