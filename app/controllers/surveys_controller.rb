class SurveysController < ApplicationController
  before_action :check_survey_exist, only: [:create, :update]
  before_action :check_survey_valid_datetime, only: [:create, :update]
  before_action :check_survey_owner, only: [:edit, :update]
  before_action :check_survey_member, only: [:show]

  def index 
    @surveys = current_user.user_surveys.sort_by{|s| s[:date].to_datetime.change({ hour: s.day_type == Survey.day_type_enums[:noon] ? 14 : 21, min: 0, sec: 0 }).in_time_zone}.reverse
  end

  def new 
    @groups = available_groups
  end

  def create 
    survey = Survey.create(user: current_user, group_id: params[:group_id], date: params[:date], day_type: params[:day_type])
    redirect_to({action: "show", id: survey.id}, notice: t('surveys.create_success'))
  end

  def edit 
    @groups = available_groups
  end

  def update 
    survey.update(group_id: params[:group_id], date: params[:date], day_type: params[:day_type])
    redirect_to({action: "edit", id: survey.id}, notice: t('surveys.update_success'))
  end

  def show 
    
  end

  private 

  def check_survey_exist
    surveys = Survey.where(group_id: params[:group_id], date: params[:date], day_type: params[:day_type])
    redirect_to({action: "new"}, error: t('surveys.already_survey')) && return if surveys.length > 0
  end

  def check_survey_valid_datetime
    is_to_late = DateTime.now.in_time_zone > Date.parse(params[:date]).to_datetime.change({hour: params[:day_type] == Survey.day_type_enums[:noon] ? 12 : 19, min: 0, sec: 0}).in_time_zone
    redirect_to({action: "new"}, error: t('surveys.is_to_late_survey')) && return if is_to_late
  end

  def available_groups
    groups = []
    current_user.user_groups.each do |ug|
      groups << ug.group
    end
    groups
  end

end