class Item
  include Mongoid::Document

  field :title, type: String

  belongs_to :list
  has_many :ranked_items

end
