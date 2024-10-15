$(document).on('turbo:before-cache', function () {

});

$(document).on('turbo:load', function() {
  
  $('form').on('click', '.remove_fields', function(event) {
    event.preventDefault();

    $(this).prev('input[type=hidden]').val('1');
    $(this).closest('fieldset').hide();
  });

  $('form').on('click', '.add_fields', function(event) {
    event.preventDefault();

    var regexp, time;

    time   = new Date().getTime();
    regexp = new RegExp($(this).data('id'), 'g');
    $(this).before($(this).data('fields').replace(regexp, time));
  });

  $('#family_is_attending').on('change', function() {
    if ($(this).val() === 'false') {
      $('#attendance_selection_wrapper').slideUp();
    } else {
      $('#attendance_selection_wrapper').slideDown();
    }
  }).change();
  
});
