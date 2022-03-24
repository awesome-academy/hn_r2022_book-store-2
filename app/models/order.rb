class Order < ApplicationRecord
  ORDER_PROPERTIES = %i(customer_name delivery_phone
                      delivery_address note).freeze

  after_update :reduce_quantity, if: ->{status_pending?}
  after_update :restore_quantity,
               if: ->{status_rejected? || status_canceled?}

  belongs_to :user
  has_many :order_details, dependent: :destroy
  has_many :books, through: :order_details

  validates :delivery_address, presence: true
  validates :delivery_phone, presence: true,
                             length: {in: Settings.phone_number_lenght}

  enum status: {pending: 0, rejected: 1, accepted: 2,
                shipped: 3, delivered: 4, canceled: 5}, _prefix: true

  scope :get_order, ->(user_id){where(user_id: user_id) if user_id.present?}
  scope :newest, ->{order created_at: :desc}

  validates :status, inclusion: {in: statuses.keys}

  private

  def restore_quantity
    order_details.each do |od|
      od.book.update! quantity: od.book.quantity + od.quantity
    end
  end

  def reduce_quantity
    order_details.each do |od|
      od.book.update! quantity: od.book.quantity - od.quantity
    end
  end

  ransacker :created_at do
    Arel.sql("date(created_at)")
  end
end
