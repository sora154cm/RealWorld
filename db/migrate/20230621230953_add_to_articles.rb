class AddToArticles < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :description, :string
    add_column :articles, :body, :text
  end
end
