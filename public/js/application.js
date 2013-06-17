$(document).ready(function() {

  var screenName = $('.username p').text();

  $.post('/freshen', {"screenname": screenName}, function(response){
    $('.tweet ul').remove();
    $('.tweet').append(response);

  });
});
  
