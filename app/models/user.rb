class User
  include Mongoid::Document
  include ActiveModel::HasSecurePassword

  field :email, type: String
  field :password_digest, type: String
  field :username, type: String
  field :gender, type: Symbol
  field :birthday, type: DateTime

  has_many :wishlists
  has_many :responses

  def age
    (DateTime.now - @birthday).years
  end

end
