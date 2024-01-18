class Product < ApplicationRecord
    belongs_to :merchant, dependent: :destroy
    has_many :orders, dependent: :destroy
    has_one_attached :image, dependent: :destroy
end
