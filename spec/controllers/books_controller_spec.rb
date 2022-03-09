require "rails_helper"

RSpec.describe BooksController, type: :controller do
  describe ".index" do
    it "should render index" do
      get :index
      expect(response).to render_template(:index)
    end
  end
  
  describe ".show" do
    context "when params_id valid" do
      let(:book){FactoryBot.create :book}
      
      before do
        get :show, params: {locale: I18n.locale, id: book.id}
      end

      it "should render show" do
        expect(response).to render_template(:show)
      end
    end

    context "when params_id invalid" do
      it "should redirect to root" do
        get :show, params: {locale: I18n.locale, id: -1}
        expect(response).to redirect_to root_path
      end
    end
  end
end
