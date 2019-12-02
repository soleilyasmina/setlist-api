class SetlistsController < ApplicationController
  before_action :set_setlist, only: [:show, :update, :destroy]

  # TODO: protect routes
  # GET /setlists
  def index
    @setlists = Setlist.all

    render json: @setlists
  end

  # GET /setlists/1
  def show
    render json: @setlist
  end

  # POST /setlists
  def create
    @setlist = Setlist.new(setlist_params)

    if @setlist.save
      render json: @setlist, status: :created, location: @setlist
    else
      render json: { errors: @setlist.errors }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /setlists/1
  def update
    if @setlist.update(setlist_params)
      render json: @setlist
    else
      render json: { errors: @setlist.errors }, status: :unprocessable_entity
    end
  end

  # DELETE /setlists/1
  def destroy
    @setlist.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_setlist
      @setlist = Setlist.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def setlist_params
      params.require(:setlist).permit(:title, :location, :time)
    end
end
