class Book < ApplicationRecord
  belongs_to :publisher
  belongs_to :category
  has_many :order_details, dependent: :destroy
  has_many :orders, through: :order_details
  has_many :book_authors, dependent: :destroy
  has_many :authors, through: :book_authors
end
