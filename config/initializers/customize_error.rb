ActionView::Base.field_error_proc = proc do |html_tag, _instance|
  class_index = html_tag.index("class=\"")

  if class_index
    html_tag.insert(class_index + 7, "is-danger ")
  else
    html_tag.insert(html_tag.index(">"), " class='is-danger'")
  end
end
