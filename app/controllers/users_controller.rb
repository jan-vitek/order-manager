class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

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

  def housekeeper_load
    #[JV] toto nemůže totkto být, po změně přiřazení se nezmění updated_at, zvážit
    #  nastavení updated_at u assignmentu po změně housekeeperů
    #if stale?(last_modified: Assignment.maximum(:updated_at).utc, template: false)
      respond_to do |format|
        format.json {render :json => User.housekeeper_load_json}
      end
    #end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

end
