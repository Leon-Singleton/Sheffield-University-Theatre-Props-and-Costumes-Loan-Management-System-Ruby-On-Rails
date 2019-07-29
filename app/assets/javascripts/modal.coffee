$ ->
  $(document).on 'ajax-modal-show', ->
    $('select.select2').select2()

    #$('#item_subcategory_id').empty()


    $('#item_subcategory_id').parent().show()
    states = $('#item_subcategory_id').html()
    $('#item_category_id').change ->
      country = $('#item_category_id :selected').text()
      escaped_country = country.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
      options = $(states).filter("optgroup[label='#{escaped_country}']").html()
      if options
        $('#item_subcategory_id').html(options)
      else
        $('#item_subcategory_id').empty()
