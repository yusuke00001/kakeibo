class TransactionsController < ApplicationController
  def index
    @transactions = Transaction.all.order(:transaction_date)
  end

  def show
    @transaction = Transaction.find(params[:id])
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

  def edit
    @transaction = Transaction.find(params[:id])
  end

  def transaction_params
    params.require(:transaction).permit(:amount, :transaction_type, :transaction_date, :note)
  end
end
