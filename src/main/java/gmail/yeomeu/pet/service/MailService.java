package gmail.yeomeu.pet.service;

import java.io.UnsupportedEncodingException;

import javax.inject.Inject;
import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import gmail.yeomeu.pet.dto.User;

@Service
public class MailService { 

    @Inject 
    private JavaMailSender mailSender ;
    private String senderEmail = "no.rep.for.javatuition@gmail.com"; 
    private String senderPersonal="PetLost Admin"; 

    public void sendMail ( User user, String title, String content) { 
        MimeMessage msg = mailSender.createMimeMessage(); 

        try { 
            /* 
             * 1. title 
             */ 
            msg.setSubject(title); 
            /* 
             * 2. content 
             */ 
            MimeMessageHelper helper = new MimeMessageHelper(msg, true, "utf-8");
            helper.setSubject(title); 
            helper.setText(content, true); 
            helper.setFrom(new InternetAddress(senderEmail, senderPersonal, "utf-8"));
            helper.setTo(new InternetAddress(user.getEmail(), name(user.getEmail()), "utf-8")); 

            
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
}
