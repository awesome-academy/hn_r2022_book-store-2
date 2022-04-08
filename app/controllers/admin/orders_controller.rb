class Admin::OrdersController < AdminController
  authorize_resource class: false

  before_action :load_order, only: %i(destroy update)
  before_action :load_and_search_orders, only: %i(index destroy update)

  def index
    accept_all_new @orders, params[:status_change] if params[:status_change]
    @pagy, @orders = pagy @orders
  end

  def update
    ActiveRecord::Base.transaction do
      @order.public_send("status_#{params[:status]}!")
    end
    refresh
  rescue ActiveRecord::RecordInvalid
    flash[:danger] = t "update_fail"
    redirect_to admin_orders_path
  end

  def destroy
    ActiveRecord::Base.transaction do
      @order.status_rejected!
    end
    refresh
  rescue ActiveRecord::RecordInvalid
    flash[:danger] = t "delete_fail"
    redirect_to admin_orders_path
  end

  private

  def load_and_search_orders
    @search = Order.ransack params[:q]
    @pagy, @orders = pagy @search.result.newest,
                          items: Settings.page_items_10
  end

  def accept_all_new order_list, status
    return unless status == Settings.status_accepted

    if order_list.public_send("status_#{Settings.status_pending}").any?
      order_list.public_send("status_#{Settings.status_pending}").each do |od|
        od.public_send("status_#{Settings.status_accepted}!")
      end
      flash[:success] = t "accept_success"
    else
      flash[:warning] = t "order_not_found"
    end
    redirect_to admin_orders_path
  end
end
