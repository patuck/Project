package com.catalog.model;


import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.logging.Level;
import java.util.logging.Logger;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Reshad
 */
public class Tree 
{
    //private Node root;
    private ArrayList<Node> nodeList=new ArrayList<Node>();
    private FileWriter fw = null;
    public Tree ()
    {
        Node root = new Node();
        root.setParentID("-1");
        root.setNodeID("0");
        root.setData("root");
        nodeList.add(root);
    }
    
    public ArrayList<Node> getList()
    {
        return nodeList;
    }
    
    public void addNode(Node n)
    {
        nodeList.add(n);
    }
    public ArrayList<Node> getParentNodes(String nodeID)
    {
        for(int i=0;i<nodeList.size(); i++)
        {
            if(nodeID.equals(nodeList.get(i).getNodeID()))
            {
                return getParentNodes(nodeList.get(i));
            }
        }
        return new ArrayList<Node>();
    }
    public ArrayList<Node> getParentNodes(Node node)
    {
        for(int i=0;i<nodeList.size(); i++)
        {
            if (nodeList.get(i).getNodeID().equals(node.getParentID()))
            {
                if(node.getParentID().equals("0"))
                {
                    ArrayList<Node> parentNodes = new ArrayList<Node>();
                    parentNodes.add(node);
                    return parentNodes;
                }
                else
                {
                    ArrayList<Node> parentNodes = getParentNodes(nodeList.get(i));
                    parentNodes.add(node);
                    return parentNodes;
                }
            }
        }
        return new ArrayList<Node>();
    }
    public void printChildNodes(String nodeID)
    {
        try 
        {
            fw.write("<ul>\n");
            for(int i=0;i<nodeList.size(); i++)
            {
                if (nodeList.get(i).getParentID().equals(nodeID))
                {
                    //fw.write("<ul>");
                    fw.write("<li><a href=\"Categories.jsp?Category=" + nodeList.get(i).getNodeID() + "\">");
                    fw.write(nodeList.get(i).getData());
                    fw.write("</a>");
                    printChildNodes(nodeList.get(i).getNodeID());
                    fw.write("</li>\n");
                }
            }
            fw.write("</ul>\n");        
        } 
        catch (IOException ex) 
        {
            System.out.println(ex.getCause());
        } 
    }
    public void makeMenu(String path)
    {
         try 
         {
             fw = new FileWriter(new File(path));
             fw.write("<div id=\"smoothmenu-ajax\" class=\"ddsmoothmenu\">");
             printChildNodes("0");
             fw.write("<br style=\"clear: left\" /> \n </div>");
             fw.close();
         } 
         catch (IOException ex) 
         {
         }
    }
    
    
    
}
