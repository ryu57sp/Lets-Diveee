class DivesController < ApplicationController

  def new
    @dive = Dive.new
  end

  def create
    @dive = Dive.new(dive_params)
    if @dive.save
      redirect_to dives_path
    else
      render :new
    end
  end

  def index
    @dives = Dive.all.includes(:user)
  end

  def show
    @dive = Dive.find(params[:id])
  end

  def edit
    @dive = Dive.find(params[:id])
  end

  def update
    @dive = Dive.find(params[:id])
    if @dive.update(dive_params)
      redirect_to dives_path
    end
  end

  def destroy
    @dive.destroy
    redirect_to dives_path
  end

  private
  def dive_params
    params.require(:dive).permit(:image, :dive_point, :title, :body, :water_temperature, :maximum_depth, :season, :dive_shop)
  end

end
