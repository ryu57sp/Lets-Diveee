class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    current_user.follow(params[:user_id])
    # 通知機能
    @user = User.find(params[:user_id])
    @user.create_notification_follow!(current_user)
  end

  def destroy
    @user = User.find(params[:user_id])
    current_user.unfollow(params[:user_id])
  end

  def followings
    @user = User.find(params[:user_id])
    @users = @user.followings
  end

  def followers
    @user = User.find(params[:user_id])
    @users = @user.followers
  end
end
