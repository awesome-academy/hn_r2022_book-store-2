require "rails_helper"

RSpec.describe User, type: :model do
  describe "Associations" do
    it {should have_many(:orders).dependent(:destroy)}
  end

  describe "Validations" do
    before {FactoryBot.build :user}

    context "with name field" do
      it{is_expected.to validate_presence_of(:name)}
      it{is_expected.to validate_length_of(:name).is_at_most(Settings.digit_50)}
    end

    context "with email field" do
      it{is_expected.to validate_presence_of(:email)}
      it{is_expected.to validate_length_of(:email).is_at_most(Settings.digit_255)}
      it { should allow_value("a@b.c").for(:email) }
      it { should_not allow_value("s").for(:email) }
    end

    context "with address field" do
      it{is_expected.to validate_presence_of(:address)}
      it{is_expected.to validate_length_of(:address).is_at_most(Settings.digit_255)}
    end

    context "with phone field" do
      it{is_expected.to validate_presence_of(:phone)}
      it{is_expected.to validate_length_of(:phone).is_at_most(Settings.digit_10)}
    end

    context "with password field" do
      it { should validate_length_of(:password).is_at_least(Settings.digit_6) }
      it { should validate_confirmation_of(:password) }
    end
  end
end
