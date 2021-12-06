class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @dive = Dive.find(params[:dive_id])
    favorite = current_user.favorites.new(dive_id: @dive.id)
    favorite.save
    redirect_to dive_path(@dive)
  end

  def destroy
    @dive = Dive.find(params[:dive_id])
    favorite = current_user.favorites.find_by(dive_id: @dive.id)
    favorite.destroy
    redirect_to dive_path(@dive)
  end

end
