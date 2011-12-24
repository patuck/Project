/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.catalog.model;

import java.util.Date;
import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;

/**
 *
 * @author Reshad
 */
public class SendMail 
{

    private String host;
    private boolean sessionDebug;
    private Properties props;
    
    public static void main(String[] args) 
    {
        SendMail m =new SendMail();
        m.sendMail("reshad.tybsc@gmail.com", "test@localhost", "test Mail", "sent from test clas with functions, ready to use in the project");
    }
    public SendMail()
    {
        // Collect the necessary information to send a simple message
        // Make sure to replace the values for host, to, and from with valid information.
        // host - must be a valid smtp server that you currently have access to.
        // servers will validate the domain of the from address
        // before allowing the mail to be sent.
        host = "localhost";
        sessionDebug = false;
        
        // Create some properties and get the default Session.
        props = System.getProperties();
        Properties props = System.getProperties();
        props.put("mail.host", host);
        props.put("mail.transport.protocol", "smtp");
    }
    
    public void sendMail(String to, String from, String subject, String text)
    {
        Session session = Session.getDefaultInstance(props, null);
        // Set debug on the Session so we can see what is going on
        // Passing false will not echo debug info, and passing true
        // will.
        session.setDebug(sessionDebug);
        try 
        {
            // Instantiate a new MimeMessage and fill it with the
            // required information.
            Message msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(from));
            InternetAddress[] address = {new InternetAddress(to)};
            msg.setRecipients(Message.RecipientType.TO, address);
            msg.setSubject(subject);
            msg.setSentDate(new Date());
            msg.setText(text);
            // Hand the message to the default transport service
            // for delivery.
            Transport.send(msg);
        }
        catch (MessagingException mex) 
        {
            mex.printStackTrace();
        }
        session = null;
    }
}