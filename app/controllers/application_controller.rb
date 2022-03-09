class ApplicationController < ActionController::Base
  include Pagy::Backend

  before_action :set_locale
  protect_from_forgery with: :exception
  include SessionsHelper
  include BooksHelper

  private
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t "error.not_found"
    redirect_to root_url
  end

  def refresh
    redirect_back fallback_location: root_url
  end

  def init_cart
    session[:cart] ||= []
    @cart = session[:cart]
  end

  def get_cart_book
    @cart.each do |item|
      @get_cart_book = item if item["book_id"] == params[:book_id].to_i
    end
  end
end
