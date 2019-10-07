class CreateJoinTableUsersBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :postings do |t|
      t.text :quote
      t.belongs_to :user
      t.belongs_to :book
      t.datetime :started_on
      t.datetime :finished_on
      t.integer :rating
      t.text :note

    end
  end
end
