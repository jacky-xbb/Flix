class MoviesController < ApplicationController
  before_action :require_signin, except: %i[index show]
  before_action :require_admin, except: %i[index show]
  before_action :set_movie, only: %i[show edit destroy update]

  def index
    @movies = case params[:filter]
              when 'upcoming'
                Movie.upcoming
              when 'recent'
                Movie.recent
              else
                Movie.released
              end
  end

  def show
    @genres = @movie.genres
    @fans = @movie.fans
    @favorite = current_user.favorites.find_by(movie: @movie) if current_user
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to @movie, notice: 'Movie successfully created!'
    else
      render :new, status: unprocessable_entity
    end
  end

  def edit; end

  def update
    if @movie.update(movie_params)
      redirect_to @movie, notice: 'Movie successfully updated!'
    else
      render :edit, status: unprocessable_entity
    end
  end

  def destroy
    @movie.destroy
    redirect_to movies_url, status: :see_other, alert: 'Movie successfully deleted!'
  end

  private

  def set_movie
    @movie = Movie.find_by!(slug: params[:slug])
  end

  def movie_params
    params.require(:movie).permit(
      :title, :description, :rating, :released_on, :total_gross, :director, :duration, :image_file_name, genre_ids: []
    )
  end
end
