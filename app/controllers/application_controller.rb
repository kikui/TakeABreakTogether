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
    redirect_to user_url(id: session[:user_id]) if session[:user_id].to_s != params[:id]
  end

end
