function hide (divid, textid, text_show, text_hide)
{
    var div = document.getElementById(divid);
    var label = document.getElementById(textid);
    label.innerHTML = (div.style.display == 'none') ?
	'<img src="/RNAWebSuite/gfx/hide.png" alt="v"><a href = "javascript:hide(\''+divid+'\',\''+textid+'\',\''+
	text_show+'\',\''+text_hide+'\');">'+text_hide+'</a>' :
	'<img src="/RNAWebSuite/gfx/show.png" alt="&gt;"><a href = "javascript:hide(\''+divid+'\',\''+textid+'\',\''+
	text_show+'\',\''+text_hide+'\');">'+text_show+'</a>';
    div.style.display = (div.style.display == 'none') ? 'block' : 'none';
}

function paste(where, tmpstring)
{
    document.getElementById(where).value = tmpstring;
}

function clear(id)
{
    document.getElementById(id).value = '';
}

function Pop(id)
{
    if (document.getElementById(id).style.visibility == "visible")
    {
	document.getElementById(id).style.visibility = "hidden";
    }
    else
    {
        document.getElementById(id).style.visibility = "visible";
    }
}

function CreateXmlHttpRequest()
{
    var xmlHttp;
    if (window.XMLHttpRequest)
    {
	//If IE7, Mozilla, Safari, and so on: Use native object
	xmlHttp = new XMLHttpRequest();
    }
    else
    {
	if (window.ActiveXObject)
	{
	    //...otherwise, use the ActiveX control for IE5.x and IE6
	    xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
	}
    }   
    return xmlHttp;
}

function ajax()
{
    url = page;
    objHttp = CreateXmlHttpRequest();
    
    objHttp.open("GET",url+"?r="+Math.round(Math.random()*100000),true);
    objHttp.send(null);
    objHttp.onreadystatechange = function() {ajaxDone(objHttp);};
    interval = window.setInterval("ajax()",5000);
}

function ajaxDone(objHttp)
{
    if (objHttp.readyState == 4)
    {
	if (objHttp.status == 200 || objHttp.status == 304)
	{
	    results = objHttp.responseText;
	    Ergebnis = results.match(/done\./);
	    if (Ergebnis)
	    {
		window.location=forwardpage;
	    }
	    else
	    {
		var str = document.getElementById('contentmain').innerHTML.toString();
		if (str == "")
		{
		    document.getElementById('contentmain').innerHTML = "<p>"+results+"</p>";
		}
		else
		{
		    
		    var temp  = results.toString().split(/\n/g);
		    var temp2 = temp[temp.length-2].replace(/(.*)(\d\d:\d\d:\d\d)(.*)/, "$2");
		    var reg = new RegExp(temp2);
	    
		    if (reg.test(str))
			//alert("NO updating");
			var tmp = "";
		    else
			document.getElementById('contentmain').innerHTML = "<p>"+results+"</p>";
		    
		}
	    }
	}
	else
	{
	    document.getElementById('contentmain').innerHTML="ajax error:\n" + objHttp.statusText;
	}
    }
}
