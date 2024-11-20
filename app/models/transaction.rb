class Transaction < ApplicationRecord
  has_many :transaction_categories
  has_many :categories, through: :transaction_categories

  validates :transaction_date, presence: true
end
