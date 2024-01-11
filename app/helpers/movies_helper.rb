module MoviesHelper
  def total_gross(movie)
    return 'Flop' if movie.flop?

    number_to_currency(movie.total_gross, precision: 0)
  end

  def average_stars_percent(movie)
    movie.average_stars * 20
  end
end
