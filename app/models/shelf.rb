class Shelf < ApplicationRecord
  belongs_to :user
  has_many :postings
end
