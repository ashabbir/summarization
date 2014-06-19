$(document).ready(function() {  
	
	//to set the responsive nav bar dropdown
	var sideslider = $('[data-toggle=collapse-side]');
	var sel = sideslider.attr('data-target');
	var sel2 = sideslider.attr('data-target-2');
	sideslider.click(function(event){
		$(sel).toggleClass('in');
		$(sel2).toggleClass('out');
	});
			
			
	//to set the nav bar active depending on path
	$('ul.nav > li > a[href="' + document.location.pathname + '"]').parent().addClass('active');
});
		
		
		
		
