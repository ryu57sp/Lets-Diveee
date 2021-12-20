class HomesController < ApplicationController
  def top
    @dives = Dive.order('id DESC').limit(4)
  end

  def about
  end

  def map
  end

end
