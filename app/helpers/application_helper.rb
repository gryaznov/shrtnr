module ApplicationHelper
  def react_component(attributes = {})
    content_tag(:div, attributes) {}
  end
end
