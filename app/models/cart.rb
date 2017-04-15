class Cart < ActiveRecord::Base
  has_many :line_items
  has_many :items, through: :line_items


  def add_item(item_id)
  end
end
