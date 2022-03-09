class StoreController < ApplicationController
  before_action :authenticate_user!
  before_action :init_cart, only: %i(cart checkout)

  def home; end

  def cart; end

  def checkout; end

  private
  def init_cart
    session[:cart] ||= []
    @cart = session[:cart]
  end
end
