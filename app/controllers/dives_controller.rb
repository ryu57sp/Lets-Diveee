class DivesController < ApplicationController

  def new
    @dive = Dive.new
  end

  def create
    @dive = Dive.new(dive_params)
    @dive.user_id = current_user.id
    if @dive.save
      redirect_to dives_path
    else
      render :new
    end
  end

  def index
    @dives = Dive.all
    @user = current_user
  end

  def show
    @dive = Dive.find(params[:id])
  end

  def edit
    @dive = Dive.find(params[:id])
    unless @dive.user == current_user
      redirect_to dives_path
    end
  end

  def update
    @dive = Dive.find(params[:id])
    if @dive.update(dive_params)
      redirect_to dives_path
    end
  end

  def destroy
    @dive = Dive.find(params[:id])
    @dive.destroy
    redirect_to dives_path
  end

  private
  def dive_params
    params.require(:dive).permit(:image, :dive_point, :title, :body, :water_temperature, :maximum_depth, :season, :dive_shop)
  end

end