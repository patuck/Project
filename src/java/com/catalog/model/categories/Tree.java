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
            
    

    
    
    public static void main (String [] args)
    {
        Tree t= new Tree("out.html");
        t.addNode(new Node("1", "0", "Phones"));
        t.addNode(new Node("2", "0", "Computers"));
        t.addNode(new Node("3", "0", "Cameras"));
        t.addNode(new Node("4", "1", "Smartphones"));
        t.addNode(new Node("5", "1", "Feature phones"));
        t.addNode(new Node("6", "2", "Laptops"));
        t.addNode(new Node("7", "2", "Desktops"));
        t.addNode(new Node("8", "4", "Nokia"));
        t.addNode(new Node("9", "4", "Samsung"));
        t.addNode(new Node("10", "4", "Apple"));
        t.addNode(new Node("11", "4", "LG"));
        t.addNode(new Node("12", "5", "Nokia"));
        t.addNode(new Node("13", "5", "Samsung"));
        t.addNode(new Node("14", "6", "Sony"));
        t.addNode(new Node("15", "6", "Dell"));
        t.addNode(new Node("16", "6", "Lenovo"));
        t.addNode(new Node("17", "7", "Dell"));
        t.addNode(new Node("18", "7", "Lenovo"));
        t.addNode(new Node("19", "7", "Acer"));
        t.addNode(new Node("20", "3", "DSLR"));
        t.addNode(new Node("21", "3", "Pont and shot"));
        t.addNode(new Node("22", "21", "Kodak"));
        t.addNode(new Node("23", "20", "Nikon"));
        t.addNode(new Node("24", "21", "Samsung"));
        
       /* ArrayList<Node> a=t.getList();
        for(int i=0;i<a.size();i++)
        {
            System.out.println(a.get(i).getParentID()+"--"+a.get(i).getNodeID()+"--"+a.get(i).getData());
        }
        
        System.out.println();
        System.out.println();
        System.out.println();
        */
        t.printChildNodes("0");
        
        /*ArrayList<Node> l= t.getParentNodes(new Node("9", "4", "Samsung"));
        for(int i=0;i<l.size();i++)
        {
            System.out.println(l.get(i).getData());
        }
        */
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
