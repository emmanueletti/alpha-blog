class User < ApplicationRecord
  # association declations
  # dependet: :destroy -> gives instructions to Rails as to what to do to dependent associations if a user is destroyed
  has_many :articles, dependent: :destroy

  # uniqueness is case sensitive by default - so "aaa" will be seen as different from "Aaa"
  # can turn it off by setting case sensitivity to false
  validates :username, presence: true,
                       uniqueness: { case_sensitive: false },
                       length: { in: 3..25 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    length: { maximum: 105 },
                    format: { with: VALID_EMAIL_REGEX }

  before_save { self.email = email.downcase }
  # RAILS MAGIC
  # uncomment bcrypt and install it, then add this line to get hashed passwords
  # read the documentation of "has_secure_password" to get the full instructions
  has_secure_password
end
