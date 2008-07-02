module ContactHelper
  def error_messages_for_attribute(object, attribute)
    if object.errors.on(attribute)
      html = '<small class="errors"><ul>'
      object.errors.on(attribute).each do |message|
        html += "<li>" + message + "</li>"
      end
      html += "</ul></small>"
    end
  end
end
