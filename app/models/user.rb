class User < ApplicationRecord
  has_many :postings
  has_many :books, through: :postings
  has_many :shelves
  accepts_nested_attributes_for :postings
  
  def self.find_or_create_from_auth_hash(auth_hash)
    user = where(provider: auth_hash.provider, uid: auth_hash.uid).first_or_create
    user.update(
      username: auth_hash.info.nickname,
      avatar: auth_hash.info.image,
      token: auth_hash.credentials.token,
      secret: auth_hash.credentials.secret
    )
    user
  end
end
