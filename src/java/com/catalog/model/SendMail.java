/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.catalog.model;


import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
/**
 *
 * @author Reshad
 */
public class SendMail
{
    public static void main(String[] args) 
    {
        SendMail m =new SendMail();
        m.sendMail("reshad.tybsc@gmail.com", "no-reply@teche.tk", "test Mail", "sent from test clas with functions, ready to use in the project");
    }
    public void sendMail(String to, String from, String subject, String text)
    {
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.socketFactory.port", "465");
        props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.port", "465");
        Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() 
        {
            protected PasswordAuthentication getPasswordAuthentication() 
            {
                return new PasswordAuthentication("no-reply@teche.tk","techeteche");
            }
        });
        try 
        {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress("no-reply@teche.tk"));
            message.setRecipients(Message.RecipientType.TO,InternetAddress.parse(to));
            message.setSubject(subject);
            message.setText(text);
            Transport.send(message);
            System.out.println("Done");
        } 
        catch (MessagingException e) 
        {
            throw new RuntimeException(e);
        }
    }
}
