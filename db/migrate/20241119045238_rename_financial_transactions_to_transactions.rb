class RenameFinancialTransactionsToTransactions < ActiveRecord::Migration[8.0]
  def change
    rename_table :financial_transactions, :transactions
  end
end
