require "rails_helper"

RSpec.describe Admin::CategoriesController, type: :controller do
  it {
    should use_before_action(:load_category)
    should use_before_action(:check_books)
  }
  let(:user_admin){FactoryBot.create :user, role: 1, confirmed_at: Time.zone.now}
  let(:category){FactoryBot.create :category}
  before do
    sign_in user_admin
  end

  describe ".index" do
    it "should show all of category" do
      get :index
    end
  end
  
  describe ".new" do
    it "should assign new category" do
      get :new
      expect(assigns(:category)).to be_a_new(Category)
    end
  end

  describe ".create" do
    context "when invalid params" do
      before do
        post :create, params:{category: {name: ""}}
      end
      it "should render new" do
        is_expected.to render_template :new
      end
    end

    context "when valid params" do
      let(:category_params){FactoryBot.attributes_for :category}
      before do
        post :create, params:{category: category_params}
      end
      it "should flash sucess message" do
        expect(flash[:success]).to eq I18n.t "created"
      end
      it "should redirect to category path" do
        expect(response).to redirect_to admin_categories_path
      end
    end
  end

  describe ".update" do
    context "when invalid params" do
      let(:category_params){FactoryBot.attributes_for :category}
      before do
        patch :update, params:{id: category.id, category: {name: ""}}
      end
      it "should flash danger" do
        expect(flash[:danger]).to eq I18n.t "update_failed"
      end
      it "should render edit" do
        is_expected.to render_template :edit
      end
    end

    context "when valid params" do
      let(:category_params){FactoryBot.attributes_for :category}
      before do
        patch :update, params:{id: category.id, category: category_params}
      end
      it "should flash success message" do
        expect(flash[:success]).to eq I18n.t "updated"
      end
      it "should show category" do
        expect(response).to redirect_to admin_categories_url
      end
    end
  end

  describe ".destroy" do
    context "when incorect params category id" do
      before do
        delete :destroy, params:{id: -1}
      end
      it "should flash danger" do
        expect(flash[:danger]).to eq I18n.t "not_found"
      end
      it "should redirect to category path" do
        expect(response).to redirect_to admin_categories_url
      end
    end

    context "when delete success" do
      before do
        delete :destroy, params:{id: category.id}
      end
      it "should flash success message" do
        expect(flash[:success]).to eq I18n.t "deleted"
      end
      it "should redirect to category path" do
        expect(response).to redirect_to admin_categories_url
      end
    end
  end
end
