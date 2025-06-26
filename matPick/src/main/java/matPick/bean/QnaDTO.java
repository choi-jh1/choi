package matPick.bean;
import java.sql.Timestamp;

public class QnaDTO {
	private int num; 		// 글 번호
	private String writer;  // 글 작성자
	private String title;	// 글 제목
	private String content; // 글 내용
	private String img;   	// 첨부파일(이미지)
	private int ask;		// 답변 상태
	private Timestamp reg;	// 작성 날짜 
	private String nick;	// 작성자 닉네임

	
	public String getNick() {
		return nick;
	}
	public void setNick(String nick) {
		this.nick = nick;
	}
	public int getAsk() {
		return ask;
	}
	public void setAsk(int ask) {
		this.ask = ask;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public void setReg(Timestamp reg) {
		this.reg = reg;
	}
	public Timestamp getReg() {
		return reg;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public String getImg() {
		return img;
	}
}