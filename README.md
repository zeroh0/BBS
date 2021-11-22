# BBS  
## JSP 게시판 제작  
###### 동빈나님의 유튜브 영상을 참고해서 제작  
###### https://www.youtube.com/playlist?list=PLRx0vPvlEmdAZv_okJzox5wj2gG_fNh_6  
JSP를 활용해 기본적인 게시판 제작을 개인적인 공부 후 스터디분들과 함께 작성한 코드 리뷰 형식으로 진행  
##### 2021.11.14 ~ 2021.11.21
- 11.14 : 1강 ~ 4강 - 로그인 페이지 디자인, 회원 데이터베이스 구축, 로그인 기능 구현
- 11.17 : 5강 ~ 9강 - 회원가입 페이지 디자인, 접속한 회원 세션 관리, 게시판 메인 페이지 디자인, 게시판 데이터베이스 구축
- 11.19 : 10강 ~ 12강 - 글쓰기 기능 구현, 게시판 글 목록 기능 구현, 게시글 보기 기능 구현
- 11.21 : 13강 ~ 15강 - 게시글 수정 및 삭제 기능 구현, 웹 사이트 메인 페이지 디자인, 프로젝트 완성 및 배포

<br>

- JDK 1.8 
- ORACLE 데이터베이스 

<br>

### 11.14 : 1강 ~ 4강
- 로그인 페이지 디자인 : login.jsp  
- 회원 데이터베이스 구축 : MEMBER 테이블 생성, User.java 생성  
- 로그인 기능 구현 : loginAction.jsp, UserDAO.java 생성 - 생성자로 데이터베이스 접근 후 login() 메소드로 데이터베이스에 존재하는 값과 입력 값 비교

<br>

### 11.17 : 5강 ~ 9강
- 회원가입 페이지 디자인 : join.jsp  
- 접속한 회원 세션 관리 : session.setAttribute() - 로그인이나 회원가입 성공 시 세션 부여, session.getAttribute() - 로그인 여부에 따라 보여지는 페이지 구성을 위해  
- 게시판 메인 페이지 디자인 : bbs.jsp  
- 게시판 데이터베이스 구축 : BBS 테이블 생성, Bbs.java 생성  

<br>

### 11.19 : 10강 ~ 12강
- 글쓰기 기능 구현 : write.jsp, writeAction.jsp, BbsDAO.java - write() 메소드로 입력 값을 BBS 테이블에 insert
- 게시판 글 목록 기능 구현 : getList() 메소드로 return 값을 ArrayList 설정해 삭제되지 않는 모든 글들이 select
- 게시글 보기 기능 구현 : view.jsp - getBbs() 메소드로 해당 게시글 번호를 get 방식으로 가져와 해당하는 게시글 정보를 보여준다.

<br>

### 11.21 : 13강 ~ 15강
- 게시글 수정 및 삭제 기능 구현 : 
  - update.jsp, updateAction.jsp - view.jsp에서 get 방식으로 게시글 번호를 가져와 해당 수정할 제목, 내용을 보여준다.  
  - deleteAction.jsp -  view.jsp에서 get 방식으로 게시글 번호를 가져와 해당 게시글을 삭제한다.
- 웹 사이트 메인 페이지 디자인 : main.jsp - Bootstrap의 Carousel을 활용
- 프로젝트 완성 및 배포 : 포트포워딩 - 작업했던 프로젝트를 war파일로 export하여 tomcat 경로로 이동시킨 후 공유기를 이용해 포트포워딩 후에 서버 실행  

