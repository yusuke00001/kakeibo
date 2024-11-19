class RenameTransactionAtInTransaction < ActiveRecord::Migration[8.0]
  def change
    rename_column :transactions, :transaction_at, :transaction_date
  end
end
