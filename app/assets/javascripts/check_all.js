
$(document).ready(function() {
  $('#check-all').click(function(){
    $('label.checkbox').each(function(){
      $(this).addClass('checked');
      $(this).find('input').prop('checked','checked');
      $(this).find('span').append('<i class="icon-check"></i>');})
  });
  $('#uncheck-all').click(function(){
    $('label.checkbox').each(function(){
      $(this).removeClass('checked');
      $(this).find('input').prop('checked',false);
      $(this).find('i').remove();})
  });
});