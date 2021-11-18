package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Date;
import java.util.ArrayList;

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
//        String sql = "select max(bbsID) from BBS";
        String sql = "select bbsID from BBS order by bbsID desc";
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

    //
    public ArrayList<Bbs> getList(int pageNumber) {
        String sql = "select * from (select * from BBS where bbsId < ? and bbsAvailable = 1 order by bbsId desc) where ROWNUM <= 10";
        ArrayList<Bbs> list = new ArrayList<Bbs>();
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
            rs = pstmt.executeQuery();
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
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    //
    public boolean nextPage(int pageNumber) {
        String sql = "select * from (select * from BBS where bbsId < ? and bbsAvailable = 1 order by bbsId desc) where ROWNUM <= 10";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
            rs = pstmt.executeQuery();
            if(rs.next()) {
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    //
    public Bbs getBbs(int bbsID) {
        String sql = "select * from BBS where bbsID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, bbsID);
            rs = pstmt.executeQuery();
            if(rs.next()) {
                Bbs bbs = new Bbs();
                bbs.setBbsID(rs.getInt(1));
                bbs.setBbsTitle(rs.getString(2));
                bbs.setUserID(rs.getString(3));
                bbs.setBbsDate(rs.getString(4));
                bbs.setBbsContent(rs.getString(5));
                bbs.setBbsAvailable(rs.getInt(6));
                return bbs;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null; // 해당 글이 존재하지 않을 때
    }
}
