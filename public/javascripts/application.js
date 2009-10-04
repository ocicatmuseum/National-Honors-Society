// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
document.getElementsByTagName("h1").onselectstart=new Function('return false');
function ds(e){return false;}
function ra(){return true;}
document.getElementsByTagName("h1").onmousedown=ds;
document.getElementsByTagName("h1").onclick=ra;