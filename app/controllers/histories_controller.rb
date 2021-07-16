class HistoriesController < ApplicationController 
  def index 
    @surveys = current_user.user_history_surveys.sort do |sa, sb|
      datetime_a = sa[:date].to_datetime.change({ hour: sa.day_type == Survey.day_type_enums[:noon] ? 14 : 21, min: 0, sec: 0 }).in_time_zone
      datetime_b = sb[:date].to_datetime.change({ hour: sb.day_type == Survey.day_type_enums[:noon] ? 14 : 21, min: 0, sec: 0 }).in_time_zone
      datetime_b <=> datetime_a
    end
    render template: "surveys/index"
  end
end