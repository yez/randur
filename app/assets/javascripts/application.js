//= require jquery
//= require random_image
//= require mobile_test

$(document).ready(function(){
	moving = false;
	image_history = [];
	image_history.unshift($('.hero').attr('src'));
	position = 0;

	$(document).on('keydown', function(e){
		if(e.keyCode == '39' || e.keyCode == '68')
		{
			goNext();
		}
		else if(e.keyCode == '37' || e.keyCode == '65')
		{
			if(moving == false)
			{
				goBack();
			}
		}
	});

	$(document).on('click', 'img.hero', function(e){
		console.log('in click');

		if(mobilecheck() == true){
			goNext();
		}
	});

	$(document).on('click', '.go-right', function(e){
		goNext();
	});

	$(document).on('click', '.go-left', function(e){
		goBack();
	});
});

function replace_image(url)
{
	$('img.hero').attr('src', url);
	$('meta[property="og:image"]').attr('content', url);
}

function goBack()
{
	position = position - 1;
	if(position >= 0)
	{
		last_img = image_history[position];
		replace_image(last_img);
		moving = false;
	}
	else
	{
		position = 0
		moving = false;
	}
}

function clickAddThisFacebook(){
	if(mobilecheck() == false)
	{
		$('.addthis_button_preferred_1').trigger('click');
	}
}

function show_spinner() {
	$("img.hero").hide();
	$('.spinner').show();
}

function hide_spinner() {
	$('.spinner').hide();
	$("img.hero").show();
}

function goNext(){
	if(typeof document.viewed == "undefined"){
		document.viewed = 1;
	}
	else{
    document.viewed = document.viewed + 1;
    if(document.viewed == 4){
    	clickAddThisFacebook();
    }
	}
	if(moving == false){
		moving = true;
		position = position + 1;
		if(typeof image_history[position] != 'undefined'){
			replace_image(image_history[position]);
			moving = false;
		}
		else{
			show_spinner();
			var randomImage = new RandomImage();
			randomImage.requestImage(function(json_response){
				image_history.push(json_response.image_url);
				replace_image(json_response.image_url);
				moving = false;
				hide_spinner();
			});
		}
	}
}



