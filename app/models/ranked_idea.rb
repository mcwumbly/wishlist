class RankedIdea
  include Mongoid::Document

  field :rank, type: Integer

  belongs_to :response
  has_one :idea

end
