module ApplicationHelper
  def record_mix_panel(mixpanel_to_record)
    "<script type='text/javascript'>mpmetrics.track(#{mixpanel_to_record});</script>" if mixpanel_to_record.present?
  end
end
