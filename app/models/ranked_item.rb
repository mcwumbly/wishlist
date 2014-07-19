class RankedItem
  include Mongoid::Document

  field :rank, type: Integer

  belongs_to :response
  belongs_to :item
  belongs_to :list

end
