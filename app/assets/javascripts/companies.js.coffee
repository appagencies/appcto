# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  # AutoHide Flash Message
  flashCallback = ->
    $(".flash-message").slideUp()
  $(".flash-message").bind 'click', (ev) =>
    $(".flash-message").slideUp()
  setTimeout flashCallback, 3000

  $('select#company_location_attributes_country').change ->
    select_wrapper = $('#region_wrapper')

    $('select', select_wrapper).attr('disabled', true)

    country_code = $(this).val()

    url = "/companies/subregion_options?parent_region=#{country_code}"
    select_wrapper.load(url)

  $(".select-btn").select2 minimumResultsForSearch: 10, width: 'off'

  $('.platform-options li').tooltip placement: 'bottom'
