require "rails_helper"
RSpec.describe StoreController, type: :controller do
  it {
    should use_before_action(:authenticate_user!)
    should use_before_action(:init_cart)
  }
end
