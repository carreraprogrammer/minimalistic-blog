class LikesController < ApplicationController
  def create
    @like = Like.new
    @like.author = current_user
    @like.post = Post.find(params[:post_id])

    # Check if the user has not already liked the post
    @like.save! unless Like.exists?(author: current_user, post: @like.post)

    redirect_to user_post_path(params[:user_id], params[:post_id])
  end
end
