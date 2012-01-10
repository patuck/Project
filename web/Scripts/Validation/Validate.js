/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


function isEmpty(formID, fieldName)
{
    if(document.forms[formID].elements[fieldName].value =="")
    {
        return true;
    }
    else
    {
        return false;
    }
}
function minLength(length, formID, fieldName)
{
    if(length > (document.forms[formID].elements[fieldName].value).length)
    {  
        return true;
    }
    else
    {
        return false;
    }
}
function isOnlyChars(formID, fieldName)
{
    var reg = /^[a-zA-Z]*$/;
    var string = document.forms[formID].elements[fieldName].value;
    if(reg.test(string) == false) 
    {
        return false;
    }
    else
    {
        return true;
    }
}
function isOnlyDigits(formID, fieldName)
{
    var reg = /^[0-9]*$/;
    var string = document.forms[formID].elements[fieldName].value;
    if(reg.test(string) == false) 
    {
        return false;
    }
    else
    {
        return true;
    }
}
function isValidUserName(formID, fieldName)
{
    var reg = /^[a-zA-Z0-9_.]*$/;;
    var string = document.forms[formID].elements[fieldName].value;
    if(reg.test(string) == false) 
    {
        return false;
    }
    else
    {
        return true;
    }
}
function containsSpace(formID, fieldName)
{
    var reg = /\s/;;
    var string = document.forms[formID].elements[fieldName].value;
    if(reg.test(string) == false) 
    {
        return false;
    }
    else
    {
        return true;
    }
}
function isEmail(formID, fieldName)
{
   var reg = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;
   var address = document.forms[formID].elements[fieldName].value;
   if(reg.test(address) == false) 
   {
      return false;
   }
   else
   {
       return true;
   }
}
function isEqualTo(formID, sourceFieldName, destinationFieldName)
{
    if(document.forms[formID].elements[sourceFieldName].value == document.forms[formID].elements[destinationFieldName].value)
    {
        return true;
    }
    else
    {
        return false;
    }
}

/*function isUsedUserName(formID, fieldName)
{
    //functionName must be a reference to a function with one parameter text. That function must check the returned text and work with the data
    var uname = "UserName="+document.forms[formID].elements[fieldName].value;
    postDataReturnText('Validation/CheckUserName', uname, makeBoolean);
}*/
function makeBoolean(text)
{
    alert(text);
    if(text == "true")
    {
        return true;
    }
    else
    {
        return false;
    }
        
}



function isUsedUserName(formID, fieldName)
{
    var url="Validation/CheckUserName";
    var data="UserName="+document.forms[formID].elements[fieldName].value;
    
  var XMLHttpRequestObject = false; 

  if (window.XMLHttpRequest) {
    XMLHttpRequestObject = new XMLHttpRequest();
  } else if (window.ActiveXObject) {
    XMLHttpRequestObject = new 
     ActiveXObject("Microsoft.XMLHTTP");
  }

  if(XMLHttpRequestObject) {
    XMLHttpRequestObject.open("POST", url); 
    XMLHttpRequestObject.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded'); 

    
    
    XMLHttpRequestObject.onreadystatechange = function() 
    { 
        
      if (XMLHttpRequestObject.readyState == 4 && 
        XMLHttpRequestObject.status == 200) {
        //alert("hi");
          //callback(XMLHttpRequestObject.responseText); 
          alert(XMLHttpRequestObject.responseText);
          var ret=XMLHttpRequestObject.responseText;
          delete XMLHttpRequestObject;
          XMLHttpRequestObject = null;
          return ret;
      } 
    }
    XMLHttpRequestObject.send(data); 
  }
}



function postDataReturnText(url, data, callback)
{ 
  var XMLHttpRequestObject = false; 

  if (window.XMLHttpRequest) {
    XMLHttpRequestObject = new XMLHttpRequest();
  } else if (window.ActiveXObject) {
    XMLHttpRequestObject = new 
     ActiveXObject("Microsoft.XMLHTTP");
  }

  if(XMLHttpRequestObject) {
    XMLHttpRequestObject.open("POST", url); 
    XMLHttpRequestObject.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded'); 

    XMLHttpRequestObject.onreadystatechange = function() 
    { 
      if (XMLHttpRequestObject.readyState == 4 && 
        XMLHttpRequestObject.status == 200) {
          callback(XMLHttpRequestObject.responseText); 
          delete XMLHttpRequestObject;
          XMLHttpRequestObject = null;
      } 
    }

    XMLHttpRequestObject.send(data); 
  }
}
