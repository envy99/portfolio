$(document).on "turbolinks:load", ->
  $(".js-sections, .js-items")
    .on "cocoon:before-insert", (e, new_element) ->
      new_element.fadeIn(400)
    .on "cocoon:before-remove", (e, element) ->
      $(this).data("remove-timeout", 400)
      element.fadeOut(400)
