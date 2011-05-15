module ApplicationHelper
  def location
    ENV["PIVOT_PONG_LOCATION"] || "NYC"
  end
end
