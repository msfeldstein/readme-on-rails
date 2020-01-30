class Posting < ApplicationRecord
  belongs_to :user
  belongs_to :book
  belongs_to :shelf
  has_many :notes, dependent: :destroy
  mount_uploader :cover, ImageUploader

  accepts_nested_attributes_for :book
  accepts_nested_attributes_for :shelf
  accepts_nested_attributes_for :notes, reject_if: :all_blank, allow_destroy: true
end