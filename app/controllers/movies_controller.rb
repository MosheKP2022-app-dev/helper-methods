class MoviesController < ApplicationController
  def new
    @movie = Movie.new

  end

  def index
    matching_movies = Movie.all

    @movies = matching_movies.order( created_at: :desc )

    respond_to do |format|
      format.json do
        render json: @list_of_movies
      end

      format.html
    
    end
  end

  def show

    # @the_movie = Movie.where( id: params.fetch(:id)).first

    # @the_movie = Movie.find_by( id: params.fetch(:id))

    @movie = Movie.find(params.fetch(:id))

  end

  def create
    movie_attributes = params.require(:movie).permit(:title, :description)

    @movie = Movie.new(movie_attributes)
  
    if @movie.valid?
      @movie.save
      redirect_to movies_url,  notice: "Movie created successfully." 
    else
      render "new"
    end
  end

  def edit
    @movie = Movie.find(params.fetch(:id))


  end

  def update
    movie_attributes = params.require(:movie).permit(:title, :description)
    @movie = Movie.find(params.fetch(:id))
    @movie.update(movie_attributes)

    # @movie.title = params.fetch(:title)
    # @movie.description = params.fetch(:description)

    if @movie.valid?
      @movie.save
      redirect_to movie_url(@movie),  notice: "Movie updated successfully."
    else
      redirect_to movie_url(@movie),  alert: "Movie failed to update successfully."
    end
  end

  def destroy
    @movie = Movie.find(params.fetch(:id))

    @movie.destroy

    redirect_to movies_url,  notice: "Movie deleted successfully."
  end
end
