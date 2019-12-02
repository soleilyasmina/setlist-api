class ProjectsController < ApplicationController
  before_action :authorize_request
  before_action :set_project, only: [:show, :update, :destroy]

  # GET /projects
  def index
    @projects = @current_user.projects.to_json(include: { setlists: { include: :songs } })

    render json: @projects, status: :ok
  end

  # GET /projects/1
  def show
    if @current_user.projects.include?(@project)
      render json: @project, status: :ok
    else
      render json: { errors: ['Project is not accessible.'] }, status: :no_content
    end
  end

  # POST /projects
  def create
    @project = Project.new(project_params)

    if @project.save
      Member.create(user_id: @current_user.id, project_id: @project.id, admin: true)
      render json: @project, status: :created, location: @project
    else
      render json: { errors: @project.errors }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /projects/1
  def update
    begin
      if Member.where(user_id: @current_user.id, project_id: params[:id]).take!.admin 
        if @project.update(project_params)
          render json: @project
        else
          render json: { errors: @project.errors }, status: :unprocessable_entity
        end
      else
        render json: { errors: ['Not admin.'] }, status: :unauthorized
      end
    rescue ActiveRecord::RecordNotFound
      render json: { errors: ['Not member of project.'] }, status: :unauthorized
    end
    
  end

  # DELETE /projects/1
  def destroy
    begin
      if Member.where(user_id: @current_user.id, project_id: params[:id]).take!.admin
        if Member.where(project_id: params[:id]).length == 0
          @project.destroy
        else
          render json: { errors: 'Members still left in project.' }
        end
      else
        render json: { errors: 'Not admin.' }, status: :unauthorized
      end
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'Not part of project.'}, status: :unauthorized
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def project_params
      params.require(:project).permit(:name, :genre)
    end
end
