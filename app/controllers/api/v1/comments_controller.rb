class Api::V1::CommentsController < Api::V1::ApplicationController
  before_action :authenticate_user
  def index
    comments = Post.find(params['post_id']).comments
    render json: comments
  rescue StandardError
    render json: { error: 'Post not found' }, status: :bad_request
  end

  def create
    comment = Comment.new(comment_params)
    comment.author = current_user
    comment.post = Post.find(params[:post_id])
    comment.text = params[:text]

    if comment.save
      render json: { message: 'Comment was succesfully created!' }, status: :created
    else
      render json: { error: 'Comment not created' }, status: :bad_request
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
