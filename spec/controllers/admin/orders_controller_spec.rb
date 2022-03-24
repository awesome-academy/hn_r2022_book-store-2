require "rails_helper"

RSpec.describe Admin::OrdersController, type: :controller do
  let(:user){FactoryBot.create :user, role: 1, confirmed_at: Time.zone.now}
  let(:order){FactoryBot.create :order, user_id: user.id}

  before do
    sign_in user
  end

  describe "before action callbacks" do
    it {is_expected.to use_before_action(:load_and_search_orders)}
  end

  describe "PATCH #update" do
    context "when update order status success" do
      before do
        patch :update, params: {id: order.id, order:{status: "pending"}}
      end
      it "should status is pending" do
        expect(order.status?).to eq true
      end
    end
    context "when update order status fail" do
      before do
        allow_any_instance_of(Order).to receive(:status_pending!).and_raise(ActiveRecord::RecordInvalid)
        patch :update, params: {id: order.id, order:{status: "pending"}}
      end
      it "should flash danger" do
        expect(flash[:danger]).to eq I18n.t "update_fail"
      end
      it "should redirect to admin orders path" do
        expect(response).to redirect_to admin_orders_url
      end
    end
  end

  describe "DELETE #destroy" do
    context "when reject order success" do
      before do
        delete :destroy, params: {id: order.id}
      end
      it "should status is rejected" do
        order.status_rejected!
        expect(order.status_rejected?).to eq true
      end
    end
    context "when reject order fail" do
      before do
        allow_any_instance_of(Order).to receive(:status_rejected!).and_raise(ActiveRecord::RecordInvalid)
        delete :destroy, params: {id: order.id}
      end
      it "should status is rejected" do
        expect(order.status_rejected?).to eq false
      end
      it "should flash danger" do
        expect(flash[:danger]).to eq I18n.t "delete_fail"
      end
      it "should redirect to admin orders path" do
        expect(response).to redirect_to admin_orders_url
      end
    end
  end
end
