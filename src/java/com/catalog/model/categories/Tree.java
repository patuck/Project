package com.catalog.model.categories;


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
    public Tree (String path)
    {
        Node root = new Node();
        root.setParentID("-1");
        root.setNodeID("0");
        root.setData("root");
        nodeList.add(root);
        try {
            fw = new FileWriter(new File(path));
        } catch (IOException ex) {
            
        }
    }
    
    public ArrayList<Node> getList()
    {
        return nodeList;
    }
    
    public void addNode(Node n)
    {
        nodeList.add(n);
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
            for(int i=0;i<nodeList.size(); i++)
            {
                if (nodeList.get(i).getParentID().equals(nodeID))
                {
                    fw.write("<ul>");
                    fw.write("<li>");
                    fw.write(nodeList.get(i).getData());
                    fw.write("</li>");
                    printChildNodes(nodeList.get(i).getNodeID());
                    fw.write("</ul>");
                }
            }
        } 
        catch (IOException ex) 
        {
            System.out.println(ex.getCause());
        } 
        if(nodeID.equals("0"))
        {
            try {
                fw.close();
            } catch (IOException ex) {
                Logger.getLogger(Tree.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }
    
    
    
}
