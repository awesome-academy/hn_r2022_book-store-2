require "rails_helper"

RSpec.describe Admin::BooksController, type: :controller do
  it {
    should use_before_action(:load_book)
    should use_before_action(:check_order_details)
  }
  let(:user_admin){FactoryBot.create :user, role: 1, confirmed_at: Time.zone.now}
  let(:book){FactoryBot.create :book}
  before do
    sign_in user_admin
  end

  describe ".index" do
    it "should show all of book" do
      get :index
    end
  end

  describe ".new" do
    it "should assign new book" do
      get :new
      expect(assigns(:book)).to be_a_new(Book)
    end
  end

  describe ".create" do
    context "when invalid params" do
      before do
        post :create, params:{book: {name: ""}}
      end
      it "should flash danger message" do
        expect(flash[:danger]).to eq I18n.t "fail"
      end
      it "should render new" do
        is_expected.to render_template :new
      end
    end
  end

  describe ".destroy" do
    context "when incorect params book id" do
      before do
        delete :destroy, params:{id: -1}
      end
      it "should flash danger" do
        expect(flash[:danger]).to eq I18n.t "not_found"
      end

      it "should redirect to root path" do
        expect(response).to redirect_to admin_books_url
      end
    end
    
    context "when delete success" do
      before do
        delete :destroy, params:{id: book.id}
      end
      it "should flash success message" do
        expect(flash[:success]).to eq I18n.t "success"
      end
      it "should redirect to book path" do
        expect(response).to redirect_to admin_books_url
      end
    end
  end
end
