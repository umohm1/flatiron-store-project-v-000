class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :line_items
  has_many :items, through: :line_items

  def add_item(item_id)
    item = Item.find_by(id: item_id)
    if self.items.include?(item)
      existing_line_item = self.line_items.find_by(item: item)
      existing_line_item.quantity += 1
      existing_line_item
    else
      new_line_item = LineItem.new(item: item, cart: self)
    end
  end

  def total
    total = 0
    self.line_items.each do |line_item|
      total += (line_item.item.price * line_item.quantity)
    end
    total
  end

  def checkout
    self.user.remove_cart
    self.line_items.each do |line_item|
      found_item = Item.find(line_item.item_id)
      found_item.inventory -= line_item.quantity
      found_item.save
    end
    self.status = 'submitted'
  end
end
