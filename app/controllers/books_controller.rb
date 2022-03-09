class BooksController < ApplicationController
  def index
    @pagy, @books = pagy Book.search(params[:term]),
                         items: Settings.page_items_10
  end

  def show
    @book = Book.find_by(id: params[:id])
    return if @book

    flash[:danger] = t "not_found"
    redirect_to root_path
  end
end
