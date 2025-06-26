package matPick.bean;

import java.sql.Timestamp;

public class QnaAnswerDTO {
	private int qnaNum;
	private int num;
	private String writer;
	private String content;
	private Timestamp reg;
	
	public int getQnaNum() {
		return qnaNum;
	}
	public void setQnaNum(int qnaNum) {
		this.qnaNum = qnaNum;
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
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}

	public Timestamp getReg() {
		return reg;
	}
	public void setReg(Timestamp reg) {
		this.reg = reg;
	}
	
	
}
