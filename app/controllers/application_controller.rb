class ApplicationController < ActionController::Base
  add_flash_types :error, :another_custom_type
  around_action :switch_locale
  before_action :check_authenticate

  def switch_locale(&action)
      locale = check_local_params(params)
      Rails.logger.debug "Locale: #{locale}"
      check_local_valid(locale, &action)
  end

  def extract_locale_from_accept_language_header
      if accept_language = request.env['HTTP_ACCEPT_LANGUAGE']
          accept_language.scan(/^[a-z]{2}/).first
      end
  end

  def check_local_params(params)
      if params.has_key?(:locale)
          return params[:locale]
      else
          return extract_locale_from_accept_language_header()
      end
  end

  def check_local_valid(locale, &action)
      if (I18n.available_locales.map(&:to_s).include?(locale))
          I18n.with_locale(locale, &action)
      else
          I18n.with_locale(I18n.default_locale, &action)
      end
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      @current_user = nil
    end
  end

  def check_authenticate
    redirect_to login_url if session[:user_id].nil?
  end

  def check_user_owner
    redirect_to user_url(id: session[:user_id]) && return if session[:user_id].to_s != params[:id] 
  end

  def check_group_owner 
    @group = Group.find(params.has_key?(:id) ? params[:id] : params[:group_id])
    redirect_to({action: "index"}, error: t('groups.not_own_group')) && return if @group.user_id != session[:user_id]
  end

  def check_survey_owner 
    @survey = Survey.find(params[:id])
    redirect_to({action: "index", controller: "surveys"}, error: t('sruveys.not_own_survey')) && return if @survey.user_id != session[:user_id]
  end

  def check_survey_member 
    @survey = Survey.find(params[:id])
    redirect_to({action: "index", controller: "surveys"}, error: t('sruveys.not_member_survey')) && return if !@survey.group.is_group_member(session[:user_id])
  end

  def check_vote_owner
    redirect_to({action: "show", controller: "surveys", id: params[:survey_id]}, error: t('surveys.not_vote_owner')) && return if params[:user_id] != session[:user_id].to_s
  end

  def check_too_late_to_vote
    survey = Survey.find(params[:survey_id])
    is_to_late = DateTime.now.in_time_zone > survey.date.to_datetime.change({hour: survey.day_type == Survey.day_type_enums[:noon] ? 12 : 19, min: 0, sec: 0}).in_time_zone
    redirect_to({action: "show", controller: "surveys", id: params[:survey_id]}, error: t('surveys.too_late_to_vote')) && return if is_to_late
  end
  
end
