class User < ApplicationRecord
    validates :user_name, presence: true
    has_many :orders, dependent: :destroy
    has_many :payments, dependent: :destroy
    has_many :transactions, dependent: :destroy
end
