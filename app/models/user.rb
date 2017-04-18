class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :validatable

  has_many :carts
  has_many :orders
  belongs_to :current_cart, class_name: "Cart"

  def new_current_cart
    if self.current_cart_id == nil
      cart = carts.create
      self.current_cart_id = cart.id
      self.save
    end
  end
end
