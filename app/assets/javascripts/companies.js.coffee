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

  # Select2 DropDown
  $(".select-btn").select2 minimumResultsForSearch: 10, width: 'off'

  # Platform Tooltips
  $('.platform-options li').tooltip placement: 'bottom'

  # Apps Toggler
  $('.app-icons li:first-child').addClass 'active'
  $('.apps-content .app:first-child').addClass 'active'

  # Screenshots Cycle
  $('.app-screenshots-inner').cycle
    fx: 'scrollHorz'
    speed: 'fast'
    timeout: 0
    pause: 1
    next: '.next'
    prev: '.prev'

  # Screenshot Cycle Nav Hover
  $(".app-screenshots .nav").fadeTo 0, 0
  $(".app-screenshots").hover (->
    $(this).find(".nav").stop().fadeTo "normal", 1
  ), ->
    $(this).find(".nav").fadeTo "normal", 0
