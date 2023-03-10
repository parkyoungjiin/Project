package com.itwillbs.project.vo;

import java.util.Arrays;

//메일 전송을 위한 Vo 
public class EmailVo {
    private String senderName;    //발신자 이름
    private String senderMail;    //발신자 이메일 주소
    private String receiveMail;    //수신자 이메일 주소
    private String subject;            //제목
    private String message;            //본문
    
    //getter,setter,toString
    public String getSenderName() {
        return senderName;
    }
    public void setSenderName(String senderName) {
        this.senderName = senderName;
    }
    public String getSenderMail() {
        return senderMail;
    }
    public void setSenderMail(String senderMail) {
        this.senderMail = senderMail;
    }
    public String getReceiveMail() {
        return receiveMail;
    }
    public void setReceiveMail(String receiveMail) {
        this.receiveMail = receiveMail;
    }
    public String getSubject() {
        return subject;
    }
    public void setSubject(String subject) {
        this.subject = subject;
    }
    public String getMessage() {
        return message;
    }
    public void setMessage(String message) {
        this.message = message;
    }
    @Override
    public String toString() {
        return "EmailDTO [senderName=" + senderName + ", senderMail=" + senderMail + ", receiveMail=" + receiveMail
                + ", subject=" + subject + ", message=" + message + "]";
    }
    

}
	
	