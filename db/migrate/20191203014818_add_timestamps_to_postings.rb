class AddTimestampsToPostings < ActiveRecord::Migration[6.0]
  def change
    add_column :postings, :created_at, :datetime, null: false, default: Time.zone.now
    add_column :postings, :updated_at, :datetime, null: false, default: Time.zone.now
  end
end
