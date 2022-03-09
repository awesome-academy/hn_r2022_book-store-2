class OrdersController < ApplicationController
  before_action :authenticate_user!

  def new; end

  def index
    @orders = Order.get_order(current_user[:id]).newest
  end

  def show
    @order = Order.get_order(current_user[:id])
    return if @order

    flash[:danger] = t "not_found"
    redirect_to root_path
  end

  def create
    init_order
    create_order_detail
    ActiveRecord::Base.transaction do
      @order.status_pending!
      @order.save!
      handle_success_create_order
    end
  rescue StandardError => e
    handle_exception e
  end

  def destroy
    ActiveRecord::Base.transaction do
      @order.status_canceled!
    end
    refresh
  rescue ActiveRecord::RecordInvalid
    flash[:danger] = t "delete_fail"
    refresh
  end

  private
  def check_login
    return if current_user

    flash[:warning] = t "please_login"
    redirect_to login_url
  end

  def order_params
    params.require(:order).permit Order::ORDER_PROPERTIES
  end

  def init_order
    @order = current_user.orders.new order_params
  end

  def create_order_detail
    @cart = session[:cart]
    @cart.each do |item|
      book = Book.find_by id: item["book_id"]
      @order.order_details.build(
        quantity: item["quantity"],
        price: book.price,
        book_id: book.id
      )
    end
    session[:cart] = []
  end

  def handle_success_create_order
    flash[:success] = t "success"
    redirect_to root_url
  end

  def handle_exception _exception
    flash[:danger] = t "error"
    redirect_back fallback_location: root_url
  end
end
