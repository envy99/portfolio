updateDynamicFields = (el) ->
  type = el.val()

  if (type != "")
    target = el.closest(".js-nested-fields").find(".js-item-content")

    fields = target.children()
    fields.hide()
    fields.keyup ->
      fields.val($(this).val())

    switch (type)
      when "text"
        target.find("textarea").attr("placeholder", "Text body").show()
      when "image"
        target.find("input").attr("placeholder", "Image URL").show()

$(document).on "turbolinks:load", ->
  $(".js-item-select").each ->
    updateDynamicFields($(this))

  $(".js-sections, .js-items")
    .on "cocoon:before-insert", (e, new_element) ->
      new_element.fadeIn(400)
    .on "cocoon:before-remove", (e, element) ->
      $(this).data("remove-timeout", 400)
      element.fadeOut(400)

  $(".js-sections")
    .on "change", ".js-item-select", ->
      updateDynamicFields($(this))
    .on "cocoon:after-insert", ".js-items", (e, element) ->
      target = element.find(".js-item-select")
      updateDynamicFields(target)
