// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
document.getElementsByTagName("p").onselectstart=new Function('return false');
function ds(e){return false;}
function ra(){return true;}
document.getElementsByTagName("p").onmousedown=ds;
document.getElementsByTagName("p").onclick=ra;