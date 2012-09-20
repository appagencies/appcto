$ ->
  # Initialize state
  $(".platform-options li :checkbox").change ->
    if $(this).is(":checked")
      $(this).parent().addClass "active"
    else
      $(this).parent().removeClass "active"

  # Platform buttons
  $(".platform-options li").click ->
    $(this).toggleClass "active"
    checkbox = $(":checkbox", this)
    checkbox.attr "checked", not checkbox.attr "checked"