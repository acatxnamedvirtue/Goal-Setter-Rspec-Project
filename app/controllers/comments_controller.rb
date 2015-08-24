class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user.id

    if @comment.save
      flash[:notices] = ["Thanks for commenting"]
    else
      flash[:errors] = @comment.errors.full_messages
    end
      redirect_to :back
  end

  def destroy
    @comment = current_user.authored_comments.destroy(params[:id])
    flash[:notices] = ["You have deleted your comment"]
    redirect_to :back
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :commentable_type, :commentable_id)
  end
end
