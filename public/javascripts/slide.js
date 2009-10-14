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
		$("#cal").show();
		$("#cal").fadeTo(1000, 1);
	});
	// Switch buttons from "Log In | Register" to "Close Panel" on click
	$("#toggle a").click(function () {
		$("#toggle a").toggle();
	});
	
	// check for what is/isn't already checked and match it on the fake ones
	$("input:checkbox").each( function() {
		(this.checked) ? $("#fake"+this.id).addClass('fakechecked') : $("#fake"+this.id).removeClass('fakechecked');
	});
	// function to 'check' the fake ones and their matching checkboxes
	$(".fakecheck").click(function(){
		($(this).hasClass('fakechecked')) ? $(this).removeClass('fakechecked') : $(this).addClass('fakechecked');
		$(this.hash).trigger("click");
		return false;
	});
	$(".day").click(function(){
		($(this).find(".fakecheck").hasClass('fakechecked')) ? $(this).find(".fakecheck").removeClass('fakechecked') : $(this).find(".fakecheck").addClass('fakechecked');
	});
		
});