module ApplicationHelper

  def menu_item(label, link)
    content_tag(:li, link_to(label, link), class: ('active' if link.ends_with?(controller_name)) )
  end
end
