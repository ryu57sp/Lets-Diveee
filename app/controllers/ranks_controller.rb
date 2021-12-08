class RanksController < ApplicationController

  def index
     @all_ranks = Dive.find(Favorite.group(:dive_id).order('count(dive_id) desc').limit(3).pluck(:dive_id))
  end

end
