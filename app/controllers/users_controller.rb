class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @liked_movies = @user.liked_movies
    @reviews = @user.reviews
  end
end
