class FavoritesController < ApplicationController
  before_action :require_signin
  before_action :set_movie

  def create
    @movie.fans << current_user
    redirect_to @movie, notice: 'Thanks for favorting!'
  end

  def destroy
    movie = current_user.liked_movies.find(params[:movie_id])
    current_user.liked_movies.destroy(movie)
    redirect_to @movie, notice: 'Sorry you unfaved it!'
  end

  private

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end
end
