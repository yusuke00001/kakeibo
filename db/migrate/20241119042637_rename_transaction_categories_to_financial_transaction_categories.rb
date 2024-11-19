class RenameTransactionCategoriesToFinancialTransactionCategories < ActiveRecord::Migration[8.0]
  def change
    rename_table :transaction_categories, :transaction_categories
  end
end
