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

  def monthly
    # 横軸を1月から12月の固定ラベルで設定
    @labels = (1..12).map { |month| "#{month}月" }

    # 収支データを月ごとに集計
    income_date = Transaction.where(transaction_type: 'income').group_by_month(:transaction_date, format: "%m", range: Date.current.beginning_of_year..Date.current.end_of_year).sum(:amount)
    expense_date = Transaction.where(transaction_type: 'expense').group_by_month(:transaction_date, format: "%m", range: Date.current.beginning_of_year..Date.current.end_of_year).sum(:amount)
    #　収支の合計金額を格納するための新しいハッシュ
    @total_values = {}
    #　収支の合計を計算
    income_date.each do |key, income_value|
      expense_value = expense_date[key] || 0
      @total_values[key] = income_value - expense_value
    end
    # データをラベルの順序に合わせて並べ替え
    @income_values = @labels.map do |label|
      month_number = label.gsub("月", "").to_i
      income_date[month_number.to_s] || 0 # 該当データがない月は0を設定
    end

    @expense_values = @labels.map do |label|
      month_number = label.gsub("月", "").to_i
      expense_date[month_number.to_s] || 0 # 該当データがない月は0を設定
    end

    @total_values = @labels.map do |label|
      month_number = label.gsub("月", "").to_i
      @total_values[month_number.to_s] || 0
    end
  end

  def transaction_params
    params.require(:transaction).permit(:amount, :transaction_type, :transaction_date, :note)
  end
end
