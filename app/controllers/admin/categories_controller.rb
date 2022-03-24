class Admin::CategoriesController < AdminController
  authorize_resource class: false

  before_action :load_category, except: %i(index new create)
  before_action :check_books, only: :destroy

  def index
    @search = Category.ransack params[:q]
    @pagy, @categories = pagy @search.result,
                              items: Settings.page_items_10
  end

  def show; end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "created"
      redirect_to admin_categories_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @category.update category_params
      flash[:success] = t "updated"
      redirect_to admin_categories_path
    else
      flash[:danger] = t "update_failed"
      render :edit
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = t "deleted"
    else
      flash[:danger] = t "delete_failed"
    end
    redirect_to admin_categories_path
  end

  private

  def category_params
    params.require(:category).permit Category::PROPERTIES
  end

  def load_category
    @category = Category.find_by id: params[:id]
    return if @category

    flash[:danger] = t "not_found"
    redirect_to admin_categories_path
  end

  def check_books
    return if @category.books.empty?

    flash[:danger] = t "dont_move_cate"
    refresh
  end
end
