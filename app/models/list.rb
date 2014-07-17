class List
  include Mongoid::Document

  field :name, type: String
  belongs_to :owner, class_name: 'User', inverse_of: :lists
  embeds_many :items
  embeds_many :responses

end
