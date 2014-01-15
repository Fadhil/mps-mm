$(document).ready(function(){
  $('#state').change(function(){
    $.ajax({
      type: 'GET',
      url: '/city_dropdown',
      data: {state: $('#state').val() },
      success: function (response) {
        $('#city').html(response);
      }
    });
  });
});