class PostsController < ApplicationController
  before_action :authenticate_user!
  layout 'standard'

  def index
    @posts = Post.includes(comments: [:author]).all
  end

  def show
    @post = Post.includes(comments: [:author]).find(params[:id])
    @like = Like.includes(post: :author).find_by(author: current_user, post: @post)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.author = current_user

    respond_to do |format|
      if @post.save
        format.html { redirect_to user_posts_path(current_user), notice: 'Post was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to root_path, notice: 'Post deleted successfully.'
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
