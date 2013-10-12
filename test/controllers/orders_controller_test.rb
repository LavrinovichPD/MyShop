require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
  fixtures :pay_types, :products
  setup do
    @order = orders(:one)
    @order.pay_type = pay_types(:one)
  end

  test "should get index" do
    orders = Order.all
    get :index
    assert_response :success
    assert_not_nil assigns(:orders)
  end

  test "should get new" do
    cart = Cart.create
    session[:cart_id] = cart.id
    LineItem.create(cart: cart, product: products(:first_cat))
    get :new
    assert_response :success
  end

  test "should create order" do
    assert_difference('Order.count') do
      post :create, order: { address: @order.address, email: @order.email, name: @order.name, pay_type_id: @order.pay_type.id }
    end

    assert_redirected_to store_path
  end

  test "should show order" do
    get :show, id: @order
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @order
    assert_response :success
  end

  test "should update order" do
    patch :update, id: @order, order: { address: @order.address, email: @order.email, name: @order.name, pay_type_id: @order.pay_type.id }
    assert_redirected_to order_path(assigns(:order))
  end

  test "should destroy order" do
    assert_difference('Order.count', -1) do
      delete :destroy, id: @order
    end

    assert_redirected_to orders_path
  end

  test "requires item in cart" do
    get :new
    assert_redirected_to store_path
    assert_equal flash[:notice], 'Your cart is empty'
  end

end
