package gmail.yeomeu.pet.service;

import java.io.UnsupportedEncodingException;

import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.inject.Inject;
import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeUtility;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import gmail.yeomeu.pet.dto.User;

@Service
public class MailService { 

    @Inject 
    private JavaMailSender mailSender ;
    
    private @Value("${senderEmail}") String senderEmail; 
    private @Value("${senderPersonal}") String senderPersonal; 

    public void sendMail ( User user, String title, String content) { 
    	
    	System.out.println(senderEmail + ": " + senderEmail);
    	System.out.println(senderPersonal + ": " + senderPersonal);
        MimeMessage msg = mailSender.createMimeMessage(); 
        
        try { 

        	MimeMessageHelper helper = new MimeMessageHelper(msg, true, "utf-8");
            helper.setSubject(title); 
            helper.setText(content, true); 
            helper.setFrom(new InternetAddress(senderEmail, senderPersonal, "utf-8"));
            helper.setTo(new InternetAddress(user.getEmail(), name(user.getEmail()), "utf-8")); 

			//파일 경로
            DataSource source = new FileDataSource("/Users/yeom/Documents/upfiles/aaa.txt");
            //파일 형식(확장자도 바꿔야 한다)
            helper.addAttachment(MimeUtility.encodeText("설명.txt","UTF-8", "B"), source);
            helper.addInline("abc", new FileDataSource("abc.jpg"));

            
            helper.setText("<html><body><img src='cid:image'></body></html>", true);
            FileSystemResource res = new FileSystemResource("/Users/yeom/Documents/upfiles/aaa.txt");
            helper.addInline("image", res);
            
            /*for(final File attachment : attachments) {
                FileSystemResource file = new FileSystemResource(attachment);
                helper.addAttachment(file.getFilename(), file);
            }*/

            /*
             * MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
		      messageHelper.setSubject("[공지] 회원 가입 안내");
		      String htmlContent = "<strong>안녕하세요</strong>, 반갑습니다." + "<img src="cid:abc">";
		      messageHelper.setText(htmlContent, true);
		      messageHelper.setFrom("gz.kyungho@gmail.com", "갱짱");
		      messageHelper.setTo(new InternetAddress(member.getEmail(), member.getName(), "UTF-8"));
		      messageHelper.addInline("abc", new FileDataSource("abc.jpg"));
		      mailSender.send(message);
             */

            /*MimeMultipart mmp = new MimeMultipart(); 
				MimeBodyPart body = new MimeBodyPart(); 
	            body.setContent(content, "text/html;charset=UTF-8"); 
	
	            mmp.addBodyPart(body); 
	            msg.setContent(mmp); 
	            msg.addRecipient(RecipientType.TO, new InternetAddress(receiverEmail));*/ 

            mailSender.send(msg); 
            System.out.println("OK!!");
            
        } catch (MessagingException e) { 
            e.printStackTrace(); 
        } catch (UnsupportedEncodingException e) { 
            // TODO Auto-generated catch block 
            e.printStackTrace(); 
        } 

    }
    private String name(String email) {
        int p = email.indexOf('@');
        return email.substring(0, p);
    }
    
    // @Sche
}
