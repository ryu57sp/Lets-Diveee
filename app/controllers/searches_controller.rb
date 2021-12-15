class SearchesController < ApplicationController
  def search
    @search = params[:search]
    @word = params[:word]
    @user = User.search(@search, @word)
  end
end
