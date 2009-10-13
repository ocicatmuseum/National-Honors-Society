$(document).ready(function() {
	
	// Expand Panel
	$("#open").click(function(){
		$("div#panel").slideDown("slow");
	
	});	
	
	// Collapse Panel
	$("#close").click(function(){
		$("div#panel").slideUp("slow");	
	});		
	
	// Collapse Panel
	$("#cover").click(function(){
		$("#calendar").animate({width: "200%", height: "200%", marginLeft: "-175px", marginTop: "-100px"}, 1500);	
	});
		
	// Switch buttons from "Log In | Register" to "Close Panel" on click
	$("#toggle a").click(function () {
		$("#toggle a").toggle();
	});		
		
});