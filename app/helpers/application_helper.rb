module ApplicationHelper
  def record_mix_panel(mixpanel_to_record)
    "<script type='text/javascript'>mpmetrics.track(#{mixpanel_to_record});</script>" if mixpanel_to_record.present?
  end

  def cp(path)
    "current" if current_page?(path)
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end

end
