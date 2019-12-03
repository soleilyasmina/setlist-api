class SetlistsController < ApplicationController
  before_action :set_setlist, only: [:show, :update, :destroy]
  before_action :set_project
  before_action :authorize_request
  before_action :can_view, only: [:index, :show]
  before_action :can_edit, only: [:create, :update, :destroy]

  # GET /projects/1/setlists
  def index
    @setlists = @project.setlists

    render json: @setlists
  end

  # GET /projects/1/setlists/1
  def show
    render json: @setlist
  end

  # POST /projects/1/setlists
  def create
    @setlist = Setlist.new(setlist_params)
    @project.setlists << @setlist

    if @setlist.save
      render json: @setlist, status: :created
    else
      render json: { errors: @setlist.errors }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /projects/1/setlists/1
  def update
    if @setlist.update(setlist_params)
      render json: @setlist
    else
      render json: { errors: @setlist.errors }, status: :unprocessable_entity
    end
  end

  # DELETE /projects/1/setlists/1
  def destroy
    @setlist.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_setlist
      @setlist = Setlist.find(params[:id])
    end

    def set_project
      @project = Project.find(params[:project_id])
    end

    # Only allow a trusted parameter "white list" through.
    def setlist_params
      params.require(:setlist).permit(:title, :location, :time)
    end

    # Allow view for setlists.
    def can_view
      render json: { errors: ['No privileges.'] }, status: :unauthorized unless @current_user.projects.include?(@project)
    end

    def can_edit
      render json: { errors: ['No admin privileges.'] }, status: :unauthorized unless Member.where(project_id: @project.id, user_id: @current_user.id).take!.admin 
    end
end
