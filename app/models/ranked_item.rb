class RankedItem
  include Mongoid::Document

  field :rank, type: Integer
  field :item_id, type: String

  embedded_in :response

end
