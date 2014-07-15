class Idea
  include Mongoid::Document

  field :title, type: String

  embedded_in :wishlist

end
