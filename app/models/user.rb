class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :validatable

  has_many :carts
  has_many :orders
  belongs_to :current_cart, class_name: "Cart"

  def current_cart=(cart)
    self.current_cart_id = cart.id if cart
    @current_cart = cart
    self.save
  end

  def current_cart
    @current_cart = Cart.find_by(id: self.current_cart_id)
  end

  def remove_cart
    self.current_cart_id = nil
    save
  end

end
