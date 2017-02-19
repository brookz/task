// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .


var refreshMessages =  (function(){
  var now = new Date().getTime();
  return function(){
    $.get('/events', {now: now, last_id: $('#events').data('last_id') }, function(response){
      now = response.now;
      $.each(response.events, function() {
        $('#events').prepend("<div class='event_"+ this.id +"'> "+ this.message +" </div>");
      });
      if(response.last_id != undefined){
        $('#events').data('last_id', response.last_id);
      }
    }, 'json');
  }
  console.log('request event');
})();
var startRefreshMessages = function(){
  refreshMessages();
  setInterval(refreshMessages, 5 * 1000);
}