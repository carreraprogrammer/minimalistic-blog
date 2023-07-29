class LikesController < ApplicationController
  def create
    @like = Like.new
    @like.author = User.includes(posts: [{ comments: [:author] }]).find(params[:user_id])
    @like.post = Post.find(params[:post_id])

    # Check if the user has not already liked the post
      if  Like.exists?(author: @like.author, post: @like.post)
        flash[:alert] = 'You have already liked this post.'
        
      else
        flash[:notice] = 'You liked the post!'
        render json: { count: @like.post.likes.count }
      end
  end
end
