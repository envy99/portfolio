elements = {
  root: document.documentElement,
  dropdowns: ".dropdown, .has-dropdown, .navbar-dropdown",
  toggleable: ".modal, .dropdown, .has-dropdown, .navbar-burger, .navbar-menu",
  removable: ".notification, .message, .tag"
}

hooks = {
  open: ".js-open",
  close: ".js-close",
  closeable: ".js-closeable"
  toggle: ".js-toggle",
  delete: ".js-delete",
  burger: ".js-burger",
  loading: ".js-disable-with-loading"
}

classes = {
  active: "is-active",
  clipped: "is-clipped",
  loading: "is-loading"
}

hotkeys = {
  close: 27 # Esc key
}

# Prevent closeable elements from closing when we click on them
preventClose = false
# Selector of elements that should be prevented from closing
preventCloseSelector = elements.dropdowns + ", " + hooks.closeable

getAll = (selector) ->
  document.querySelectorAll(selector)

getTargetByData = (el, dataName) ->
  data = el.getAttribute("data-#{dataName}")
  document.getElementById(data)

hasClass = (el, className) ->
  el.classList.contains(className)

addClass = (el, className) ->
  el.classList.add(className) if el

removeClass = (el, className) ->
  el.classList.remove(className) if el

removeClassFromAll = (selector, className) ->
  getAll(selector).forEach (el) ->
    el.classList.remove(className)

toggleClass = (el, className) ->
  el.classList.toggle(className) if el

document.addEventListener "turbolinks:load", ->
  getAll(hooks.open).forEach (el) ->
    el.addEventListener "click", ->
      target = getTargetByData(el, "target")
      addClass(target, classes.active)
      addClass(elements.root, classes.clipped) if hasClass(target, "modal")

  getAll(hooks.close).forEach (el) ->
    el.addEventListener "click", ->
      target = el.closest(elements.toggleable)
      removeClass(target, classes.active)
      removeClass(elements.root, classes.clipped) if hasClass(target, "modal")

  getAll(hooks.toggle).forEach (el) ->
    el.addEventListener "click", (e) ->
      e.stopPropagation();
      target = getTargetByData(el, "target")
      target = if target then target else el.closest(elements.toggleable)
      toggleClass(target, classes.active)

  getAll(hooks.delete).forEach (el) ->
    el.addEventListener "click", ->
      target = el.closest(elements.removable)
      target.remove() if target

  getAll(preventCloseSelector).forEach (el) ->
    el.addEventListener "click", ->
      preventClose = true

  getAll(hooks.burger).forEach (el) ->
    el.addEventListener "click", (e) ->
      e.stopPropagation();
      preventClose = false
      target = getTargetByData(el, "target")
      toggleClass(target, classes.active)
      toggleClass(el, classes.active)

  getAll(hooks.loading).forEach (el) ->
    el.addEventListener "click", ->
      el.blur()
      addClass(el, classes.loading)

  document.addEventListener "keydown", (e) ->
    if (e.keyCode == hotkeys.close)
      selector = elements.toggleable + ", " + hooks.closeable
      removeClassFromAll(selector, classes.active)

  document.addEventListener "click", ->
    if preventClose
      preventClose = false
      return
    removeClassFromAll(preventCloseSelector, classes.active)
