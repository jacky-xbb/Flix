class ReviewsController < ApplicationController
  before_action :require_signin, only: %i[new create]
  before_action :set_movie

  def new
    @review = Review.new
  end

  def index
    @reviews = @movie.reviews
  end

  def create
    @review = @movie.reviews.new(review_params)
    @review.user = current_user
    if @review.save
      redirect_to movie_path(@movie), notice: 'Thanks for your review!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def review_params
    params.require(:review).permit(:stars, :comment)
  end

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end
end
