class Book < ApplicationRecord
  has_many :users, through: :postings
  has_many :postings
end
