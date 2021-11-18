package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

// 데이터베이스 접근 객체 : 실질적으로 데이터베이스에서 회원정보를 불러오거나 회원정보를 넣고자할때 사용
public class UserDAO {
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;

    // 생성자 하나의 객체를 만들었을때 자동으로 Connection이 되도록
    public UserDAO() {
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

    // 하나의 계정에 대한 로그인 시도
    public int login(String userID, String userPassword) {
        String sql = "select userPassword from MEMBER where userID = ?";
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userID); //SQL injection같은 해킹 기법을 방어하기 위한 기법
            rs = pstmt.executeQuery();
            if (rs.next()) { // 아이디가 있음
                if (rs.getString(1).equals(userPassword)) {
                    return 1; // 로그인 성공
                } else {
                    return 0; // 비밀번호 불일치
                }
            }
            return -1; //아이디가 없음
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -2; //데이터베이스 오류
    }

    public int join(User user) { //한명의 사용자 입력
        String sql = "insert into MEMBER values (? ,?, ?, ?, ?)";
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, user.getUserID());
            pstmt.setString(2, user.getUserPassword());
            pstmt.setString(3, user.getUserName());
            pstmt.setString(4, user.getUserGender());
            pstmt.setString(5, user.getUserEmail());
            return pstmt.executeUpdate(); // insert문의 경우 0이상의 숫자가 반환 , 해당 SQL 문 실행에 영향을 받는 행 수를 반환
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; //데이터베이스 오류
    }

}
