class TransactionsController < ApplicationController
  def index
    @transactions = Transaction.all.order(:transaction_date).page(params[:page]).per(10)
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
      flash[:notice] = "作成されました"
    else
      render :new
      flash[:alert] = "作成に失敗しました"
    end
  end

  def edit
    @transaction = Transaction.find(params[:id])
  end

  def update
    @transaction = Transaction.find(params[:id])
    if @transaction.update(transaction_params)
      redirect_to transaction_path(@transaction)
      flash[:notice] = "更新されました"
    else
      render :edit
      flash[:alert] = "更新が失敗しました"
    end
  end

  def destroy
    @transaction = Transaction.find(params[:id])
    @transaction.destroy
    redirect_to transactions_path
    flash[:notice] = "削除が成功しました"
  end

  def transaction_params
    params.require(:transaction).permit(:amount, :transaction_type, :transaction_date, :note)
  end
end
