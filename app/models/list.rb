class List
  include Mongoid::Document

  field :name, type: String
  belongs_to :owner, class_name: 'User', inverse_of: :lists
  has_many :items
  has_many :responses
  has_many :ranked_items

end
