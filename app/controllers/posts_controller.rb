class PostsController < ApplicationController
  layout 'standard'

  def index
    @posts = Post.all
    @user = User.find_by(id: params[:user_id])
  end

  def show
    @post = Post.find_by(id: params[:id])
  end

  def new 
    @post = Post.new
  end
end
