class Order < ApplicationRecord
  ORDER_PROPERTIES = %i(customer_name delivery_phone
                      delivery_address note).freeze

  belongs_to :user
  has_many :order_details, dependent: :destroy
  has_many :books, through: :order_details

  validates :delivery_address, presence: true
  validates :delivery_phone, presence: true,
                             length: {in: Settings.phone_number_lenght}

  enum status: {pending: 0, canceled: 1, accepted: 2, shipped: 3, delivered: 4}

  scope :get_order, ->(user_id){where(user_id: user_id) if user_id.present?}
end
