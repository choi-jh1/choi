package matPick.bean;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class UsersDTO { // 유저 - 아이디, 이름, 닉네임, 비밀번호, email, 통신사, 휴대폰 번호, 가입날짜, 생년월일, 성별
   private String id;
   private String name;
   private String nick;
   private String pw;
   private String email;
   private String telecom;
   private String phone;
   private Timestamp reg;
   private Timestamp birth_date;
   private String auto; // 추후 자동로그인시 이용할 거
   private String gender;
   private String role;
   private String status;
   private Timestamp withdraw;
   
   
   	public Timestamp getWithdraw() {
   		return withdraw;
	}
	public void setWithdraw(Timestamp withdraw) {
		this.withdraw = withdraw;
	}
	public void setRole(String role) {
		   this.role = role;
   }
   public void setStatus(String status) {
	   this.status = status;
   }
   public void setAuto(String auto) {
      this.auto = auto;
   }
   public void setId(String id) {
      this.id = id;
   }
   public void setName(String name) {
      this.name = name;
   }
   public void setNick(String nick) {
      this.nick = nick;
   }
   public void setPw(String pw) {
      this.pw = pw;
   }
   public void setEmail(String email) {
      this.email = email;
   }
   public void setTelecom(String telecom) {
      this.telecom = telecom;
   }
   public void setPhone(String phone) {
      this.phone = phone;
   }
   public void setReg(Timestamp reg) {
      this.reg = reg;
   }
   public void setBirth_date(String birthDateStr) {
       if (birthDateStr != null && !birthDateStr.isEmpty()) {
    	   // 날짜 형식 지정
    	   DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd[ HH:mm:ss]");
           LocalDate localDate = LocalDate.parse(birthDateStr,formatter);
        // LocalDate를 LocalDateTime으로 변환 후 Timestamp 생성
           this.birth_date = Timestamp.valueOf(localDate.atStartOfDay());
       }
   }
   public void setGender(String gender) {
      this.gender = gender;
   }
   
   public String getRole() {
	   return role;
   }
   public String getStatus() {
	   return status;
   }
   public String getId() {
      return id;
   }
   public String getName() {
      return name;
   }
   public String getNick() {
      return nick;
   }
   public String getPw() {
      return pw;
   }
   public String getEmail() {
      return email;
   }
   public String getTelecom() {
      return telecom;
   }
   public String getPhone() {
      return phone;
   }
   public Timestamp getReg() {
      return reg;
   }
   public Timestamp getBirth_date() {
      return birth_date;
   }

   public String getGender() {
      return gender;
   }
   public String getAuto() {
      return auto;
   }
}
