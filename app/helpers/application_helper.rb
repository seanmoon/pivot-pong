module ApplicationHelper
  def link_to_with_current(name, url)
    options = (current_page? url) ? { class: "current" } : {}
    link_to name, url, options
  end

  def location
    ENV["PIVOT_PONG_LOCATION"] || "NYC"
  end
end
