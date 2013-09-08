$(function() {
  var source    = $("#order-template").html();
  var template  = Handlebars.compile(source);

  $.getJSON('/order', null, function(data) {
    if(data) {
      var html = template(data);
      $('#order').html(html);
    }
  });
  
});