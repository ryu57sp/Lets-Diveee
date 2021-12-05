class DiveCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @dive = Dive.find(params[:dive_id])
    @comment = current_user.dive_comments.new(comment_params)
    @comment.dive_id = @dive.id
    @comment.save
    redirect_to dive_path(@dive.id)
  end

  def destroy
    DiveComment.find_by(id: params[:id]).destroy
    redirect_to dive_path(params[:dive_id])
  end

  private
  def comment_params
    params.require(:dive_comment).permit(:comment, :reply)
  end

end
