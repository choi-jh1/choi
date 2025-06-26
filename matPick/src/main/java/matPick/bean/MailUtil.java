package matPick.bean;
import java.util.Properties; // 메일 서버 설정값
import javax.mail.*; // 메일 서버 연결 및 인증
import javax.mail.internet.*; // 위 패키지와 다름, 이메일 메시지의 구성요소(주소 등)

public class MailUtil {
	public static void sendTempPw(String toEmail, String tempPw) throws Exception{
	// 메일 서버 설정 -> 보낼 이메일 계정과 비밀번호 설정 -> 세션 설정 -> 메일 내용 작성 -> 메일 전송
		Properties props = new Properties();
		props.put("mail.smtp.host", "smtp.gmail.com");	// gmail SMTP 서버주소
		props.put("mail.smtp.port", "587"); 			// gmail TLS 포트
		props.put("mail.smtp.auth", "true");			// 로그인 필요 여부
		props.put("mail.smtp.starttls.enable", "true"); // TLS 암호화 사용
		
		String fromEmail = "matpick2025@gmail.com";		// 보낼사람의 gmail 주소
		String password = "eqjp lhbh actl aneb"; 		// gmail 앱 비밀번호
		Session session = Session.getInstance(props, new Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(fromEmail, password);
			}
		});
		Message message = new MimeMessage(session); 	 // 세션에서 메일 객체 생성
		message.setFrom(new InternetAddress(fromEmail)); // 보낸사람 주소
		message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
		message.setSubject("맛은 픽하는 시대 MAT.PICK, 임시 비밀번호 발급 안내"); // 메일 제목
		message.setText("회원님의 임시 비밀번호는 다음과 같습니다:\n\n" + tempPw);
		
		Transport.send(message);
	}
}
