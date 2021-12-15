class BookmarksController < ApplicationController
  before_action :authenticate_user!

  def index
    @bookmarks = Bookmark.includes(:dive).includes(dive: :user).where(user_id: current_user.id).order('id DESC').page(params[:page]).per(4)
  end

  def create
    @dive = Dive.find(params[:dive_id])
    bookmark = @dive.bookmarks.new(user_id: current_user.id)
    bookmark.save
  end

  def destroy
    @dive = Dive.find(params[:dive_id])
    bookmark = @dive.bookmarks.find_by(user_id: current_user.id)
    bookmark.destroy
  end
end
