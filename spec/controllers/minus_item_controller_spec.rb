require "rails_helper"

RSpec.describe MinusItemsController, type: :controller do
  it {
    should use_before_action(:init_cart)
    should use_before_action(:get_cart_book)
  }
end
