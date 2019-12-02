class AuthenticationController < ApplicationController
  before_action :authorize_request, only: [:verify, :update]

  # POST /auth/login
  def login
    @user = User.find_by_username(params[:username])
    if @user.authenticate(params[:password])
      token = encode(user_id: @user.id, username: @username)
      render json: { token: token, user: @user.as_json.except("password_digest") }, status: :ok
    else
      render json: { errors: ['Unauthorized'] }, status: :unauthorized
    end
  end

  # POST /auth/register
  def register
    @user = User.new(user_params)

    if @user.save
      token = encode(user_id: @user.id, username: @user.username)
      render json: { token: token, user: @user.as_json.except("password_digest") }, status: :ok
    else
      render json: { errors: @user.errors }, status: :unprocessable_entity
    end
  end

  # GET /auth/verify
  def verify
    render json: @current_user.as_json.except("password_digest"), status: :ok
  end

  # PUT /auth/update
  def update
    if @current_user.update(user_params)
      render json: @current_user.as_json.except("password_digest"), status: :ok
    else
      render json: { errors: @current_user.errors } , status: :unprocessable_entity
    end
  end

  private
    
    def user_params
      params.require(:user).permit(:email, :username, :password, :first_name, :last_name)
    end
end
