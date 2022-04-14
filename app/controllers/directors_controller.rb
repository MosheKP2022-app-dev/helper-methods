class DirectorsController < ApplicationController
  def new
    @director = Director.new

  end

  def index
    matching_directors = Director.all

    @directors = matching_directors.order( created_at: :desc )

    respond_to do |format|
      format.json do
        render json: @list_of_directors
      end

      format.html
    
    end
  end

  def show

    @director = Director.find(params.fetch(:id))

  end

  def create
    director_attributes = params.require(:director).permit(:first_name, :last_name, :bio)

    @director = Director.new(director_attributes)
  
    if @director.valid?
      @director.save
      redirect_to directors_url,  notice: "director created successfully." 
    else
      render "new"
    end
  end

  def edit
    @director = Director.find(params.fetch(:id))


  end

  def update
    director_attributes = params.require(:director).permit(:first_name, :last_name, :bio)
    @director = Director.find(params.fetch(:id))
    @director.update(director_attributes)

    if @director.valid?
      @director.save
      redirect_to director_url(@director),  notice: "director updated successfully."
    else
      redirect_to director_url(@director),  alert: "director failed to update successfully."
    end
  end

  def destroy
    @director = Director.find(params.fetch(:id))

    @director.destroy

    redirect_to directors_url,  notice: "director deleted successfully."
  end


end