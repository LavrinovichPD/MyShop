require 'test_helper'

class CartTest < ActiveSupport::TestCase
  fixtures :products
  # test "the truth" do
  #   assert true
  # end
  test "total price should be correct for the one product" do
    cart = Cart.create
    5.times do |time|
      cart.add_product(products(:first_cat).id).save!
    end
    assert_equal 1, cart.line_items.count
    assert_equal 500, cart.total_price
  end

  test "total price should be correct for several products" do
    cart = Cart.create
    5.times do |time|
      cart.add_product(products(:first_cat).id).save!
      cart.add_product(products(:second_cat).id).save!
    end
    assert_equal 2, cart.line_items.count
    assert_equal 1500, cart.total_price
  end
end
