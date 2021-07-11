class HistoriesController < ApplicationController 
  def index 
    @surveys = current_user.user_history_surveys.sort_by{|s| s[:date].to_datetime.change({ hour: s.day_type == Survey.day_type_enums[:noon] ? 14 : 21, min: 0, sec: 0 }).in_time_zone}
    render template: "surveys/index"
  end
end