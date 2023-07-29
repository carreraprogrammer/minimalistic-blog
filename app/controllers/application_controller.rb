class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Añade esta línea para manejar los errores de autorización de Cancancan
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_url, alert: exception.message
  end

  # Define el método `current_ability` para que Cancancan pueda utilizarlo
  def current_ability
    @current_ability ||= Ability.new(current_user)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name email photo bio])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name email])
  end
end
