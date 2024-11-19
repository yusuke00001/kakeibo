class RenameFinancialTransactionCategoriesToTransactionCategories < ActiveRecord::Migration[8.0]
  def change
    rename_table :financial_transaction_categories, :transaction_categories
  end
end
