class Shelf < ApplicationRecord
  belongs_to :user
  has_many :postings
  has_many :books, through: :postings
end
