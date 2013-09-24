require 'test_helper'

class LineItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "total price should be correct" do
    cart = Cart.new
    product = Product.new(title: 'Title', description: 'Description', image_url: '123.png', price: 1)
    line_item = LineItem.new(cart: cart, product: product, quantity: line_items(:two).quantity)
    assert_equal line_item.total_price, 2
  end
end
