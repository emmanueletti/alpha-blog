class AddUserIdToArticles < ActiveRecord::Migration[7.0]
  # for a add_column change (instructions given to RAILS for it to build the necesarry SQL query)
  # first give the table to apply the change to, the column to add,
  # and the field type
  def change
    add_column :articles, :user_id, :int
  end
end
