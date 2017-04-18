class Cart < ActiveRecord::Base
    belongs_to :user
    has_many :line_items
    has_many :items, through: :line_items

  def total
    cart_total = 0
    line_items.each do |line_item|
        cart_total += line_item.item.price * line_item.quantity
    end
    cart_total
  end

  def cart_checkout
    self.status = "submitted"
    line_items.each do |line_item|
        line_item.item.inventory = line_item.item.inventory - line_item.quantity
        line_item.item.save
    end

    self.save
  end

  def add_item(item)
    added_item = line_items.find_by(item_id: item)
    if added_item
        added_item.quantity +=  1
    else
        added_item = line_items.build(item_id: item)
     end
     added_item
  end
end
