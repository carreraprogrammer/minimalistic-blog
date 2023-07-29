class CommentsController < ApplicationController
  load_and_authorize_resource
  layout 'standard'
  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author = current_user
    @comment.post = Post.find(params[:post_id])

    respond_to do |format|
      if @comment.save
        format.html do
          redirect_to user_post_path(params[:user_id], params[:post_id]), notice: 'Comment was successfully created.'
        end
      else
        format.html { render :new }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html do
        redirect_to user_post_path(params[:user_id], params[:post_id]), notice: 'Comment was successfully destroyed.'
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
