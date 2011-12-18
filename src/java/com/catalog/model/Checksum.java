package com.catalog.model;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.logging.Level;
import java.util.logging.Logger;
/**
 *
 * @author Reshad
 */
public class Checksum 
{
    String  algorithim;
            
    public static void main(String [] args)
    {
        Checksum s=new Checksum();
        System.out.println(s.getSum("root"));
    }
    
    
    public Checksum()
    {
        algorithim="SHA-512";
    }
    public void setAlgorithim(String algorithim)
    {
        this.algorithim=algorithim;
    }
    
    public String getSum(String input)
    {
        String output=null;
        MessageDigest md;
        
        try 
        {
            md = MessageDigest.getInstance(algorithim);
            md.update(input.getBytes());
            byte [] sum = md.digest();
            output = byteArrayToHexString(sum);
        } 
        catch (NoSuchAlgorithmException ex) 
        {
            Logger.getLogger(Checksum.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return output;
    }
    private String byteArrayToHexString(byte[] b) 
    {
        StringBuilder sb = new StringBuilder(b.length * 2);
        for (int i = 0; i < b.length; i++) 
        {
            int v = b[i] & 0xff;
            if (v < 16)
            {
                sb.append('0');
            }
            sb.append(Integer.toHexString(v));
        }
        return sb.toString().toUpperCase();
    }
}

