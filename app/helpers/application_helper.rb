module ApplicationHelper
  def format_date(date)
    date.strftime("%Y年%m月%d日")
  end
end
