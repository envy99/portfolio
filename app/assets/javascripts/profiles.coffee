$(document).on "turbolinks:load", ->
  $(".js-sections")
    .on "cocoon:before-insert", (e, new_section) ->
      new_section.fadeIn(400)
    .on "cocoon:before-remove", (e, section) ->
      $(this).data("remove-timeout", 400)
      section.fadeOut(400)
