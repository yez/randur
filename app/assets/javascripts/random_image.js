function RandomImage(){};

RandomImage.prototype.requestImage = function (callback) {
   $.ajax({
    dataType:'json',
    url: '/new_url',
    complete: function(data, response, text){
      var json_response = JSON.parse(data.responseText);
      if (callback){
        callback(json_response);
      }
    }
  });
};