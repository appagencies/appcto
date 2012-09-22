$ ->
  # Platform buttons
  $(".platform-options li").click ->
    $(this).toggleClass "active"
    checkbox = $(":checkbox", this)
    checkbox.attr "checked", not checkbox.attr "checked"