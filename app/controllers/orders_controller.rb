class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy, :time_entries]

  # GET /orders
  def index
    @orders = Order.order('lower(name)').all
    respond_to do |format|
      format.html
      format.json { render json: @orders }
    end
  end

  # GET /orders/1
  def show
    @time_entries = @order.time_entries
    respond_to do |format|
      format.html { render layout: true }
      format.json { render json: @order }
    end
  end

  # GET /orders/new
  def new
    @order = Order.new
    respond_to do |format|
      format.html { render layout: false }
      format.json { render json: @order }
    end
  end

  # GET /orders/1/edit
  def edit
    render layout: false
  end

  # POST /orders
  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order }
        format.json { render json: @order, status: :created }
        format.js
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PATCH/PUT /orders/1
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order }
        format.json { head :no_content }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /orders/1
  def destroy
    respond_to do |format|
      if @order.destroy    
        format.html { redirect_to orders_url }
        format.json { head :no_content }
        format.js
      else
        format.html { redirect_to orders_url }
        format.json { render json: @order.errors, status: :forbidden }
        format.js { render status: :forbidden }
      end
    end
  end

  def time_entries
    @time_entries = @order.time_entries
    render partial: "time_entries/table"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def order_params
      params.require(:order).permit(:name, :customer, :received_at, :finished_at, :deadline_at, :invoiced, :state, :spent_time, :price, :comment, :description)
    end
end
