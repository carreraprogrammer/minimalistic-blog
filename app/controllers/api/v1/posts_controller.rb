class Api::V1::PostsController < Api::V1::ApplicationController
  before_action :authenticate_user
  def index
    posts = User.find(params['user_id']).posts
    render json: posts
  rescue StandardError
    render json: { error: 'User not found' }, status: :bad_request
  end
end
