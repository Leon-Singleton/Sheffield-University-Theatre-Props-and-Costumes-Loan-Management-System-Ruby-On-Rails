# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->

  $('#search_subcategory_id').parent().show()
  states = $('#search_subcategory_id').html()
  $('#search_category_id').change ->
    country = $('#search_category_id :selected').text()
    escaped_country = country.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
    options = $(states).filter("optgroup[label='#{escaped_country}']").html()
    if options
      $('#search_subcategory_id').html(options)
    else
      $('#search_subcategory_id').empty()
