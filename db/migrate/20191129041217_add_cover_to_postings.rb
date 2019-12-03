class AddCoverToPostings < ActiveRecord::Migration[6.0]
  def change
    add_column :postings, :cover, :string
  end
end
