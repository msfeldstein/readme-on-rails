class AddShelfToPosting < ActiveRecord::Migration[6.0]
  def change
    create_table :shelves do |t|
      t.string :name
      t.belongs_to :user
    end
    change_table :postings do |t|
      t.belongs_to :shelf
    end
  end
end
