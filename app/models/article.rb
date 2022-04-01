# by inheriting from ApplicationRecord, we have access to getters and setters and
# methods for connecting to and working with the database (e.g. CRUD operations).
# (methods such as .save)
# Can play around with these in the Rails console

# We add constraints to how this model can be used and the database records that
# can be created using this class
class Article < ApplicationRecord
  belongs_to :user
  
  # Rails validation syntax to add contraints to the creation of new article
  # records in the database
  validates :title, presence: true, length: { minimum: 6, maximum: 100 }
  validates :description, presence: true, length: { minimum: 10, maximum: 300 }
end
