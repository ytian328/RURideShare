package jsp;

import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;

public class Email {
	
	final private String username = "";
	final private String password = "";
	private Properties properties;
	private Authenticator authenticator;
	private Session session;
	private String from;
	
	public Email() {
		properties = new Properties();
	    properties.put("mail.smtp.auth", "true");
	    properties.put("mail.smtp.starttls.enable", "true");
	    properties.put("mail.transport.protocol", "smtp");
	    properties.put("mail.smtp.host", "smtp.live.com");
	    properties.put("mail.smtp.port", "587");
	    
	    properties.put("mail.smtp.auth", "true");
	    authenticator = new Authenticator() {
	        protected PasswordAuthentication getPasswordAuthentication() {
	            return new PasswordAuthentication(username, password);
	        }
	    };
	    
	    session = Session.getInstance(properties, authenticator);
	    
	    from = "rurideshare@hotmail.com";
	}
	
	public void send(String to, String subject, String text){
		try{
			MimeMessage message = new MimeMessage(session);
	        message.setFrom(new InternetAddress(from));
	        message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
	        message.setSubject(subject);
	        message.setText(text);
	        Transport.send(message);
	        System.out.println("Sent message successfully....");
		}
		catch(MessagingException mex){
			mex.printStackTrace();
		}
	}

	
	
	
	
}
