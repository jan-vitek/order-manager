class TimeEntriesController < ApplicationController
  before_action :set_time_entry, only: [:show, :edit, :update, :destroy]

  # GET /time_entries
  def index
    @time_entries = TimeEntry.all
    respond_to do |format|
      format.html
      format.json { render json: @time_entries }
    end
  end

  def log_time
    user = User.find_by_id(params[:user_id])
    order = Order.find_by_id(params[:order_id])
    seconds = params[:seconds]
    if user.nil? or order.nil? or seconds.nil?
      head 400
      return
    end
    entry = TimeEntry.where(order_id: order.id, user_id: user.id).first_or_create
    entry.increase_time(seconds)
    render json: {time_entry_id: entry.id, spent_time: entry.spent_time, sent_time: params[:sent_time], order_spent_time: order.spent_time}  
  end

  # GET /time_entries/1
  def show
    respond_to do |format|
      format.html { render layout: false }
      format.json { render json: @time_entry }
    end
  end

  # GET /time_entries/new
  def new
    @time_entry = TimeEntry.new
    @time_entry.user_id = params[:userId]
    @time_entry.order_id = params[:orderId]
    respond_to do |format|
      format.html { render layout: false }
      format.json { render json: @time_entry }
    end
  end

  # GET /time_entries/1/edit
  def edit
    render layout: false
  end

  # POST /time_entries
  def create
    @time_entry = TimeEntry.new(time_entry_params)

    respond_to do |format|
      if @time_entry.save
        format.html { redirect_to @time_entry }
        format.json { render json: @time_entry, status: :created }
        format.js
      else
        format.html { render :new }
        format.json { render json: @time_entry.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PATCH/PUT /time_entries/1
  def update
    respond_to do |format|
      if @time_entry.update(time_entry_params)
        format.html { redirect_to @time_entry }
        format.json { head :no_content }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @time_entry.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /time_entries/1
  def destroy
    respond_to do |format|
      if @time_entry.destroy    
        format.html { redirect_to time_entries_url }
        format.json { head :no_content }
        format.js
      else
        format.html { redirect_to time_entries_url }
        format.json { render json: @time_entry.errors, status: :forbidden }
        format.js { render status: :forbidden }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_time_entry
      @time_entry = TimeEntry.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def time_entry_params
      params.require(:time_entry).permit(:user_id, :spent_time, :note, :order_id)
    end
end
