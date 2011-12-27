package com.catalog.model.categories;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Reshad
 */
public class Node 
{
    private String nodeID;
    private String parentID;
    private String data;
    
    public Node(String nodeID, String parentID, String data)
    {
        this.nodeID=nodeID;
        this.parentID=parentID;
        this.data=data;
    }

    Node() 
    {
        ;
    }
    public void setNodeID(String nodeID)
    {
        this.nodeID=nodeID;
    }
    public String getNodeID()
    {
        return nodeID;
    }
    public void setParentID(String parentID)
    {
        this.parentID=parentID;
    }
    public String getParentID()
    {
        return parentID;
    }
    public void setData(String data)
    {
        this.data=data;
    }
    public String getData()
    {
        return data;
    }
    
    
    
}
