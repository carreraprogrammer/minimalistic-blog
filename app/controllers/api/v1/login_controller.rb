require 'jwt'
require 'knock'

class Api::V1::LoginController < Api::V1::ApplicationController

  def create
    user = User.find_by(email: params[:email])

    if user&.valid_password?(params[:password])
      token = generate_jwt_token(user)
      render json: { api_token: token }
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  private

  def generate_jwt_token(user)
    Knock::AuthToken.new(payload: { sub: user.id }).token
  end
end