class Response
  include Mongoid::Document

  has_many :ranked_items
  belongs_to :user
  belongs_to :list

  def backfill
    self.list.items.each do |item|
      ri = self.ranked_items.where({item: item}).first
      if ri == nil
        ri = RankedItem.new
        ri.item = item
        ri.rank = 0
        self.ranked_items << ri
      end
    end
  end

end
