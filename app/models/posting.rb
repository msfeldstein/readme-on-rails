class Posting < ApplicationRecord
  belongs_to :user
  belongs_to :book
  belongs_to :shelf
  has_many :notes

  accepts_nested_attributes_for :book
  accepts_nested_attributes_for :shelf
end