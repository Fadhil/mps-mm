$(document).ready(function(){
  var media_profile_select = $('#media_profile_select')
  var edit_recipients_button = $('.edit-recipients')
  media_profile_select.change(function(){
    edit_recipients_button.removeClass('hide');
  });
});