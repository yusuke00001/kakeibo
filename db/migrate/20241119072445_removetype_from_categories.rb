class RemovetypeFromCategories < ActiveRecord::Migration[8.0]
  def change
    remove_column :categories, :type
  end
end
