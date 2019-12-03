class SongsController < ApplicationController
  before_action :set_song, only: [:show, :update, :destroy]
  before_action :set_project
  before_action :authorize_request
  before_action :can_view, only: [:index, :show]
  before_action :can_edit, only: [:create, :update, :destroy]
  
  # GET /projects/1/songs
  def index
    @songs = @project.songs

    render json: @songs
  end

  # GET /projects/1/songs/1
  def show
    render json: @song
  end

  # POST /projects/1/songs
  def create
    @song = Song.new(song_params)
    @project.songs << @song

    if @song.save
      render json: @song, status: :created
    else
      render json: { errors: @song.errors }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /projects/1/songs/1
  def update
    if @song.update(song_params)
      render json: @song
    else
      render json: { errors: @song.errors }, status: :unprocessable_entity
    end
  end

  # DELETE /projects/1/songs/1
  def destroy
    @song.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_song
      @song = Song.find(params[:id])
    end

    def set_project
      @project = Project.find(params[:project_id])
    end

    # Only allow a trusted parameter "white list" through.
    def song_params
      params.require(:song).permit(:title, :length)
    end

    def can_view
      render json: { errors: ['No privileges.'] }, status: :unauthorized unless @current_user.projects.include?(@project)
    end

    def can_edit
      render json: { errors: ['No admin privileges.'] }, status: :unauthorized unless Member.where(project_id: @project.id, user_id: @current_user.id).take!.admin 
    end
end
