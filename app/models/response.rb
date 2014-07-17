class Response
  include Mongoid::Document

  embeds_many :ranked_items
  belongs_to :user
  embedded_in :list

end
