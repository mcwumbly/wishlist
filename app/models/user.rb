class User
  include Mongoid::Document
  include ActiveModel::SecurePassword

  field :email, type: String
  field :password_digest, type: String
  field :username, type: String
  field :gender, type: Symbol
  field :birthday, type: DateTime

  has_many :lists

  has_secure_password

  def age
    (DateTime.now - @birthday).years
  end

end
