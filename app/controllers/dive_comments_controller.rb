class DiveCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @dive = Dive.find(params[:dive_id])
    @comment = current_user.dive_comments.new(comment_params)
    @comment.dive_id = @dive.id
    @comment.save
    #通知機能
    @dive.create_notification_comment!(current_user, @comment.id)
  end

  def destroy
    @dive = Dive.find(params[:dive_id])
    DiveComment.find_by(id: params[:id]).destroy
  end

  private
  def comment_params
    params.require(:dive_comment).permit(:comment, :reply)
  end

end
