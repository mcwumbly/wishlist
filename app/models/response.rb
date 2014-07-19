class Response
  include Mongoid::Document

  has_many :ranked_items
  belongs_to :user
  belongs_to :list

  def initialize options={}
    super
    self.list.items.each do |item|
      puts '###########'
      puts item.inspect
      ri = self.ranked_items.where({item: item}).first
      if ri == nil
        ri = RankedItem.new
        ri.item = item
        ri.rank = 5
        self.ranked_items << ri
      end
    end
  end

end
