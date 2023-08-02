class LikesController < ApplicationController
  def create
    @like = Like.new
    @like.author = User.includes(posts: [{ comments: [:author] }]).find(current_user.id)
    @like.post = Post.find(params[:post_id])

    @like.save! unless Like.exists?(author: @like.author, post: @like.post)

    respond_to do |format|
      format.html { redirect_to user_post_path(@like.author.id, @like.post.id) }
    end
  end

  def destroy
    @like = Like.find_by(author_id: current_user.id, post_id: params[:id])

    if @like
      @like.decrease_likes_counter
      @like.destroy
    end

    respond_to do |format|
      format.html { redirect_to user_post_path(current_user.id, params[:id]) }
    end
  end
end
