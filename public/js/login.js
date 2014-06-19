function successlogin(){
	var textfield = $("input[name=username]");
	$("#output").addClass("alert alert-success animated fadeInUp").html("Welcome back " + "<span style='text-transform:uppercase'>" + textfield.val() + "</span>");
	$("#output").removeClass(' alert-danger');
	$("input").css({
		"height":"0",
		"padding":"0",
		"margin":"0",
		"opacity":"0"
	});
	
	$('button[type="submit"]').hide();
	$( ".inner" ).append( "<a href='/contact' class='btn btn-info btn-block'> continue</a>" );
            
	//show avatar
	$(".avatar").css({
		"background-image": "url('images/me.jpg')"
	});
}

function faillogin(msg){
	$("#output").removeClass(' alert alert-success');
	$("#output").addClass("alert alert-danger animated fadeInUp").html(msg);
}

$(function(){
	var textfield = $("input[name=username]");
	
	console.log(textfield.val());
	$('button[type="submit"]').click(function(e) {
		e.preventDefault();
		//little validation just to check username
		if (textfield.val() != "") {
			var jqxhr = $.post( "/login", $( "#loginform" ).serialize(),function(data) {
				
				if(data.login == "success") {
					successlogin();
				} else {
					faillogin("username password incorrect ")
				}
			})
			//$("body").scrollTo("#output");
			successlogin();
			
			
		} else {
			//remove success mesage replaced with error message
			faillogin("sorry enter a username ")
		}

	});
	
	
	
});