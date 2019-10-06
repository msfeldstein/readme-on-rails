class Posting < ApplicationRecord
  belongs_to :user
  belongs_to :book
  belongs_to :shelf

  accepts_nested_attributes_for :book
end