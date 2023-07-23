class PostsController < ApplicationController
  layout 'standard'

  def index
    @posts = Post.all.order(created_at: :desc)
    @user = User.find_by(id: params[:user_id])
  end

  def show
    @post = Post.find_by(id: params[:id])
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

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end

end
