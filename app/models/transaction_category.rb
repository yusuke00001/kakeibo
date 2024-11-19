class TransactionCategory < ApplicationRecord
  belong_to :transaction
  belong_to :category
end
