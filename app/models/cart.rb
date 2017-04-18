class Cart < ActiveRecord::Base
  has_many :line_items
  has_many :items, through: :line_items
  belongs_to :user


  def add_item(item_id)
    if existing = line_items.find_by(item_id: item_id)
      existing.quantity += 1
      existing
    else
      LineItem.new(item_id: item_id, cart_id: self.id)
    end
  end

  def total
    total = 0
    self.line_items.each do |line_item|
    total += line_item.item.price * line_item.quantity
    end
    return total
  end

  def checkout
    self.status = "submitted"
    change_inventory
  end

  def change_inventory
    if self.status = "submitted"
      self.line_items.each do |line_item|
        line_item.item.inventory -= line_item.quantity
        line_item.item.save
      end
    end
  end
end
