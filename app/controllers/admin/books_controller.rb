class Admin::BooksController < AdminController
  before_action :load_book, except: %i(index new create)
  before_action :check_order_detail, except: %i(destroy)

  def index
    @pagy, @books = pagy Book.recent_add.search(params[:term]),
                         items: Settings.page_items_10
  end

  def show; end

  def new
    @book = Book.new
    @book.book_authors.build
  end

  def create
    @book = Book.new book_params
    params.dig(:book, :book_authors, :author_id)&.compact_blank!&.each do |val|
      @book.book_authors.build[:author_id] = val
    end

    if @book.save
      flash[:success] = t ".success"
      redirect_to admin_books_path
    else
      flash.now[:danger] = t ".fail"
      render :new
    end
  end

  def edit; end

  def update
    ActiveRecord::Base.transaction do
      book_image_attach

      @book.update! book_params
      handle_success_update_book
    end
  rescue StandardError => e
    handle_exception e
  end

  def destroy
    check_order_detail

    if @book.destroy
      flash[:success] = t ".success"
    else
      flash.now[:danger] = t ".fail"
    end
    redirect_to [:admin, @book]
  end

  private

  def book_params
    params.require(:book).permit Book::PROPERTIES
  end

  def load_book
    @book = Book.find_by id: params[:id]
    return if @book

    flash[:danger] = t "not_found"
    redirect_to admin_root_path
  end

  def book_image_attach
    @book.images.attach params[:book][:images] if params[:book][:images]
  end

  def insert_to_book_author
    params.dig(:book, :book_authors, :author_id)&.compact_blank!&.each do |val|
      @book.book_authors.build[:author_id] = val
    end
  end

  def handle_success_update_book
    flash[:success] = t "success"
    redirect_to admin_books_path
  end

  def handle_exception _exception
    flash[:danger] = t "error"
    redirect_back fallback_location: admin_books_path
  end

  def check_order_detail
    return if @book.order_details.present?

    flash.now[:danger] = t "dont_move"
    redirect_to admin_root_path
  end
end
