class Wishlist
  include Mongoid::Document

  belongs_to :user
  embeds_many :ideas
  embeds_many :responses

end
