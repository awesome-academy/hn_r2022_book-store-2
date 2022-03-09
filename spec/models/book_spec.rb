require "rails_helper"

RSpec.describe Book, type: :model do
  describe "Associations" do
    it{is_expected.to belong_to(:publisher)}
    it{is_expected.to belong_to(:category)}
    it{is_expected.to have_many(:order_details).dependent(:nullify)}
    it{is_expected.to have_many(:orders).through(:order_details)}
    it{is_expected.to have_many(:book_authors).dependent(:destroy)}
    it{is_expected.to have_many(:authors).through(:book_authors)}
    it{is_expected.to have_many_attached(:images)}
    it{is_expected.to have_many(:carts).dependent(:destroy)}
  end

  describe "Validations" do
    before {FactoryBot.build :book}

    context "with name field" do
      it{is_expected.to validate_presence_of(:name)}
      it{is_expected.to validate_length_of(:name).is_at_most(Settings.max_name)}
    end

    context "with desc field" do
      it{is_expected.to validate_presence_of(:desc)}
      it{is_expected.to validate_length_of(:desc).is_at_most(Settings.max_desc)}
    end

    context "with nopage field" do
      it{is_expected.to validate_presence_of(:nopage)}
      it{is_expected.to validate_numericality_of(:nopage).only_integer.is_greater_than(Settings.zero)}
    end

    context "with quantity field" do
      it{is_expected.to validate_presence_of(:quantity)}
      it{is_expected.to validate_numericality_of(:quantity).only_integer.is_greater_than_or_equal_to(Settings.zero)}
    end

    context "with price field" do
      it{is_expected.to validate_presence_of(:price)}
      it{is_expected.to validate_numericality_of(:price).is_greater_than(Settings.zero)}
    end
  end

  describe "scope" do
    let(:book){FactoryBot.create :book}
  end
end
