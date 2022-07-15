document.addEventListener('click', function() {
  $('[scheduleId]').click( function () {
    $(`#scheduleDetail${$(this).attr('scheduleId')}`).hide();
  });
});
