module ApplicationHelper

  def flash_render
    alerts = { alert: "", notice: "alert-success", error: "alert-danger"}
    flash.map do |type, message|
      content_tag :div, t(message), class: "alert #{alerts[type]}"
    end.join("").html_safe
  end

end
