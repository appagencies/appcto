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

  # Platform Tooltips
  $('.platform-options li').tooltip placement: 'bottom'

  # Apps Toggler
  $('.app-icons li:first-child').addClass 'active'
  $('.apps-content .app:first-child').addClass 'active'

  # Screenshots Cycle
  $('.app-screenshots-inner').each ->
    p = @parentNode
    $(@).cycle
      fx: 'scrollHorz'
      speed: 'fast'
      timeout: 0
      pause: 1
      next: $(".next", p)
      prev: $(".prev", p)

    # Screenshot Cycle Nav Hover
    $(".nav", p).hide() # Hide all navbars
    if($(@).children().length > 1) # Only show navbars where there is more then 1 screenshot
      $(p).hover (->
        $(@).find(".nav").stop().fadeTo "normal", 1
      ), ->
        $(@).find(".nav").fadeTo "normal", 0

  # Back To Top display
  $(window).scroll ->
    unless $(this).scrollTop() is 0
      $(".backtotop").fadeIn()
    else
      $(".backtotop").fadeOut()

  # Select2
  $(".select-btn").select2 minimumResultsForSearch: 10, width: 'resolve'

  # Show Remove on Hover
  $(".remove_nested_fields").hide() # Hide all remove-links

  $(".app-screenshots .fields").hover (->
    $(@).find(".remove_nested_fields").stop().fadeTo "normal", 1
  ), ->
    $(@).find(".remove_nested_fields").fadeTo "normal", 0

  # Edit Apps Tabs
  $(".apps-nav a").click (e) ->
    e.preventDefault()
    $(this).tab "show"
  $('.app-show.new').addClass 'active'
  $('.apps-nav .new').addClass 'active'

