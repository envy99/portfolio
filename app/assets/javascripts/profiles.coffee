updateDynamicFields = (el) ->
  type = el.val()

  if (type != "")
    target = el.closest(".js-nested-fields").find(".js-content")
    target.children().not("label").hide()

    switch (type)
      when "text"
        target.find("textarea").show()
      when "image"
        target.find("input").show()

setupDynamicFields = (el) ->
  updateDynamicFields(el)
  el.on "change", ->
    updateDynamicFields(el)

$(document).on "turbolinks:load", ->
  $(".js-select").each ->
    setupDynamicFields($(this))

  $(".js-sections, .js-items")
    .on "cocoon:before-insert", (e, new_element) ->
      new_element.fadeIn(400)
    .on "cocoon:before-remove", (e, element) ->
      $(this).data("remove-timeout", 400)
      element.fadeOut(400)

  $(".js-items")
    .on "cocoon:after-insert", (e, element) ->
      target = element.find(".js-select")
      setupDynamicFields(target)
