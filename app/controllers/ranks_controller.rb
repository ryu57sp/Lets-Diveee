class RanksController < ApplicationController
  def index
    @all_ranks = Dive.find(Favorite.group(:dive_id).where(created_at: Time.current.all_day).order('count(dive_id) desc').limit(3).pluck(:dive_id))
  end
end
