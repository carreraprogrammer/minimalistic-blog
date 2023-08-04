class Api::V1::ApplicationController < ActionController::API
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name email photo bio])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name email])
  end

  def authenticate_user
    unless user_signed_in?
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  private

  def user_signed_in?
    !!current_user
  end

  def current_user
    @current_user ||= Knock::AuthToken.new(token: token_from_request_headers).entity_for(User)
  rescue Knock.not_found_exception_class, JWT::DecodeError
    nil
  end

  def token_from_request_headers
    pattern = /^Bearer /
    header  = request.env['HTTP_AUTHORIZATION'] 
    header.gsub(pattern, '') if header&.match(pattern)
  end
end
