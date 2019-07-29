//= require jquery
//= require jquery_ujs
//= require jquery.remotipart
//= require ajax_setup
//= require ajax_modal
//= require bootstrap
//= require flash_message
//= require visibility_map
//= require modal
//= require select2
//= require select2_init
//= require_cable.js
//= require_items
//= require_items.js
//= require moment
//= require Chart.bundle
//= require chartkick
//= require bootstrap-datetimepicker
//= require_tree .


$(function() {
    $("select#items_category_id").on("change", function() {
        $.ajax({
            url:  "/filter_subcategories_by_category",
            type: "GET",
            data: { selected_category: $("select#items_category_id").val() }
        });
    });
});
