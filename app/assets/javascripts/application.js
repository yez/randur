// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

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
});

function replace_image(url)
{
	$('img').attr('src', url);
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


function goNext()
{
	if(moving == false)
	{
		moving = true;
		position = position + 1;
		if(typeof image_history[position] != 'undefined')
		{
			replace_image(image_history[position]);
			moving = false;
		}
		else
		{
			$.ajax({
				dataType:'json',
				url: '/new_url',
				complete: function(data, response, text){
					var json_response = JSON.parse(data.responseText);
					image_history.push(json_response.image_url);
					replace_image(json_response.image_url);
					moving = false;
				}
			});
		}
	}
}