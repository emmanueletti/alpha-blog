class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  # uniqueness is case sensitive by default - so "aaa" will be seen as different from "Aaa"
  # can turn it off by setting case sensitivity to false
  validates :username, presence: true,
                       uniqueness: { case_sensitive: false },
                       length: { in: 3..25 }
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    length: { maximum: 105 },
                    format: { with: VALID_EMAIL_REGEX }
end
