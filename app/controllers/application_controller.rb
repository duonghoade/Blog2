class ApplicationController < ActionController::Base

  before_action :set_locale

  def new_session_path(scope)
    new_user_session_path
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale

  end
  private

  def default_url_options(options={})
    logger.debug "default_url_options is passed options: #{options.inspect}\n"
    { :locale => I18n.locale }
  end
  def access_denied
    redirect_to user_registration, notice: "Please login to continue" and return false
  end
end
