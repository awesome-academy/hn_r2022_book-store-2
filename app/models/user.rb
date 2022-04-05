class User < ApplicationRecord
  PROPERTIES = %i(name email address phone
    password password_confirmation remember_me).freeze

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :omniauthable, omniauth_providers: %i(google_oauth2)

  has_many :orders, dependent: :destroy

  validates :name, presence: true,
    length: {maximum: Settings.digit_50}
  validates :email, presence: true,
    length: {maximum: Settings.digit_255},
    format: {with: Settings.email_regex},
    uniqueness: {case_sensitive: false}
  validates :address, presence: true,
    length: {maximum: Settings.digit_255}
  validates :phone, presence: true,
    length: {maximum: Settings.digit_10}
  validates :password, presence: true,
    length: {minimum: Settings.digit_6},
    allow_nil: true

  enum role: {user: 0, admin: 1}

  class << self
    def from_omniauth auth
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[0, 20]
        user.name = auth.info.name
        user.skip_confirmation!
        user.save
      end
    end
  end
end
