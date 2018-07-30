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

dataNames = {
  target: "target"
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

getData = (el, dataName) ->
  el.getAttribute("data-#{dataName}") if el

getTargetById = (el) ->
  data = getData(el, dataNames.target)
  document.getElementById(data) if data

hasClass = (el, className) ->
  el.classList.contains(className) if el

addClass = (el, className) ->
  el.classList.add(className) if el

removeClass = (el, className) ->
  el.classList.remove(className) if el

removeClassFromAll = (selector, className) ->
  getAll(selector).forEach (el) ->
    removeClass(el, className)

toggleClass = (el, className) ->
  el.classList.toggle(className) if el

document.addEventListener "turbolinks:load", ->
  getAll(hooks.open).forEach (el) ->
    el.addEventListener "click", (e) ->
      e.stopPropagation();
      target = el.closest(elements.toggleable)
      target = getTargetById(el) if getData(el, dataNames.target)
      addClass(target, classes.active)
      addClass(elements.root, classes.clipped) if hasClass(target, "modal")

  getAll(hooks.close).forEach (el) ->
    el.addEventListener "click", (e) ->
      e.stopPropagation();
      target = el.closest(elements.toggleable)
      target = getTargetById(el) if getData(el, dataNames.target)
      removeClass(target, classes.active)
      removeClass(elements.root, classes.clipped) if hasClass(target, "modal")

  getAll(hooks.toggle).forEach (el) ->
    el.addEventListener "click", (e) ->
      e.stopPropagation();
      target = el.closest(elements.toggleable)
      target = getTargetById(el) if getData(el, dataNames.target)
      toggleClass(target, classes.active)

  getAll(hooks.delete).forEach (el) ->
    el.addEventListener "click", ->
      target = el.closest(elements.removable)
      target = getTargetById(el) if getData(el, dataNames.target)
      target.remove() if target

  getAll(preventCloseSelector).forEach (el) ->
    el.addEventListener "click", ->
      preventClose = true

  getAll(hooks.burger).forEach (el) ->
    el.addEventListener "click", (e) ->
      e.stopPropagation();
      preventClose = false
      target = getTargetById(el) if getData(el, dataNames.target)
      toggleClass(target, classes.active) if target
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
