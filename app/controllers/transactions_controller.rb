class TransactionsController < ApplicationController

  def index
    @transactions = Transaction.all.includes(:categories).order(:transaction_date)
  end
  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = Transaction.new(transaction_params)
    if @transaction.save
    redirect_to transactions_path
    else
    render :new
    end
  end

  def transaction_params
    params.require(:transaction).permit(:id, :amount, :transaction_type, :transaction_date, :note)
  end
end
