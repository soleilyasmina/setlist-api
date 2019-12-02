class MembersController < ApplicationController
  before_action :set_project
  before_action :set_member, only: [:update, :destroy]
  before_action :authorize_request, only: [:update, :destroy]
  before_action :set_member_user, only: [:update, :destroy]

  # GET projects/1/members
  def index
    render json: @project.users, status: :ok
  end

  # POST project/1/members/
  def create
    @member = Member.new(project_id: @project.id, user_id: params[:user_id], admin: params[:admin])
    
    if @member.save
      render json: @member, status: :ok
    else
      render json: { errors: @member.errors }, status: :unprocessable_entity
    end
  end

  # PUT project/1/members/1
  def update
    if @member.admin == params[:admin]
      render json: { errors: ['Status did not change.'] }, status: :conflict
    elsif !@member_user.admin
      render json: { errors: ['No admin privileges'] }, status: :unauthorized
    else 
      if (@member.update(admin: params[:admin]))
        render json: @member, status: :ok
      else
        render json: { errors: @member.errors }, status: :unprocessable_entity
      end
    end
  end

  # DELETE project/1/members/1
  def destroy
    if !@member_user.admin
      render json: { errors: ['No admin privileges.'] }, status: :unauthorized
    elsif @member.admin
      render json: { errors: ['Member being removed is an admin.'] }, status: :unauthorized
    else
      @member.destroy
    end
  end

  private

    def set_member
      @member = Member.where(project_id: params[:project_id], user_id: params[:id]).first
    end

    def set_member_user
      @member_user = Member.where(project_id: params[:project_id], user_id: @current_user.id).first
    end

    def set_project
      @project = Project.find(params[:project_id])
    end
end
