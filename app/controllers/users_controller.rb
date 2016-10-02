class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  before_filter :check_if_admin
  # GET /users
  def index
    @users = User.all
    respond_to do |format|
      format.html
      format.json { render json: @users }
    end
  end

  # GET /users/1
  def show
    respond_to do |format|
      format.html { render layout: false }
      format.json { render json: @user }
    end
  end

  # GET /users/new
  def new
    @user = User.new
    respond_to do |format|
      format.html { render layout: false }
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    render layout: false
  end

  # POST /users
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user }
        format.json { render json: @user, status: :created }
        format.js
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PATCH/PUT /users/1
  def update
    user_params = user_params()
    
    if (user_params[:password] != user_params[:password_confirmation]) or user_params[:password].blank?
      user_params.except!(:password, :password_confirmation)
    end
      
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user }
        format.json { head :no_content }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /users/1
  def destroy
    respond_to do |format|
      if @user.destroy
        format.html { redirect_to users_url }
        format.json { head :no_content }
        format.js
      else
        format.html { redirect_to users_url }
        format.json { render json: @user.errors, status: :forbidden }
        format.js { render status: :forbidden }
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def check_if_admin
      if signed_in?
        render text: "Only admins allowed!" unless current_user.admin
      else
        render text: 'Please sign in!'
      end
    end

    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:admin ,:name, :email, :password, :password_confirmation)
    end

end
