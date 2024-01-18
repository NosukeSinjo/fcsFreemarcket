class Merchant < ApplicationRecord
    belongs_to :user, dependent: :destroy
    belongs_to :product, dependent: :destroy
end
