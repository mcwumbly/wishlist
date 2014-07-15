class Response
  include Mongoid::Document

  has_many :ranked_ideas
  embedded_in :wishlist

end
