$('.input-daterange').datepicker(
  format: 'dd/mm/yyyy'
)
$('#filter-date').click ->
  start = $('input[name="start"]').val()
  end = $('input[name="end"]').val()
  location.href = '/records?start=' + start + '&end=' + end

