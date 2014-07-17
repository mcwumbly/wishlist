class Item
  include Mongoid::Document

  field :title, type: String

  embedded_in :list

end
