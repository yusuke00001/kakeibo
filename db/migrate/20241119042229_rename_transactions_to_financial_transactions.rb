class RenameTransactionsToFinancialTransactions < ActiveRecord::Migration[8.0]
  def change
    rename_table :transactions, :transactions
  end
end
