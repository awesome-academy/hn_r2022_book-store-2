class CreateOrderDetailJob < ApplicationJob
  queue_as :default

  def perform order, cart
    @order = order
    @cart = cart
    @cart.each do |item|
      book = Book.find_by id: item["book_id"]
      @order.order_details.build(
        quantity: item["quantity"],
        price: book.price,
        book_id: book.id
      )
    end
    @order.order_details.each do |od|
      @order.order_price += od.quantity * od.price
    end
    @order.save
  end
end
