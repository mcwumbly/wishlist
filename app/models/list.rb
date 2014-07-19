class List
  include Mongoid::Document

  field :name, type: String
  belongs_to :owner, class_name: 'User', inverse_of: :lists
  has_many :items
  has_many :responses

  def ranked_items
    self.items.inject(Array.new) { | a, item |
      a << RankedItem.new({
        item: item,
        rank: self.responses.inject(0) { |sum, r|
          sum += r.ranked_items.where({item: item}).sum(&:rank)}
        })
    }.sort_by { |r| -r.rank }
  end

  def total_score
    self.ranked_items.sum(&:rank)
  end

  def max_score
    self.ranked_items.inject(Array.new) { |a, item| a << item.rank }.max
  end

  def ranked_items_loop
  # loop way
  ranked_items = []
  self.items.each do |item|
    ranked_items_for_item = []
    self.responses.each do |response|
      ranked_items_for_item << response.ranked_items.where({item: item}).first
    end
    rank = 0
    ranked_items_for_item.each do |ri|
      rank += ri.rank
    end
    ranked_items << RankedItem.new({ item: item, rank: rank })
  end
  ranked_items
  end

end
