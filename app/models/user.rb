class User < ActiveRecord::Base
  has_many :posts 

  #we register an inline callback directly after the before_save callback
  before_save { self.email = email.downcase if email.present? }

  #we use Ruby's validates function to ensure that name is present and has a max and min length
  validates :name, length: { minimum: 1, maximum: 100 }, presence: true

  #we validate password with two separate validations:
  #1: executes if password_digest is nil. This ensures that when we create a new user, they have a valid password
  validates :password, presence: true, length: { minimum: 6 }, if: "password_digest.nil?"
  #2 ensures that when updating a user's password, the updated password is also six characters long.
  #allow_blank:true skips the validation if no updated password is given. This allows us to change other attributes on a user without being forced to set the password
  validates :password, length: { minimum: 6 }, allow_blank: true
  #we validate that email is present, unique, case insensitive, has a min & max length and that it is properly formatted
  validates :email,
             presence: true,
             uniqueness: { case_sensitive: false },
             length: { minimum: 3, maximum: 254 }
  #This function abstracts away much of the complexity of obfuscating user passwords using hashing algorithms which we would otherwise be inclined to write to securely save passwords.
  has_secure_password
end
