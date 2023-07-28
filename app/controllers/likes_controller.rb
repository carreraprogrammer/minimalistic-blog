class LikesController < ApplicationController
  def create
    @like = Like.new
    @like.author = User.includes(posts: [{ comments: [:author] }]).find(params[:user_id])
    @like.post = Post.find(params[:post_id])

    # Check if the user has not already liked the post
    unless Like.exists?(author: @like.author, post: @like.post)
      @like.save!
      redirect_to user_post_path(params[:user_id], params[:post_id])
    end
  end
end
