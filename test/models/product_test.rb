require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products

   test "products attributes must not be empty" do
     product = Product.new
     assert product.invalid?
     assert product.errors[:title].any?
     assert product.errors[:description].any?
     assert product.errors[:image_url].any?
     assert product.errors[:price].any?
   end

  test "product price must be positive" do
    product = Product.new( title: 'some title',
                            description: 'some description',
                            image_url: 'cat2.jpg' )
    product.price = -1
    assert product.invalid?
    assert_equal "must be greater than or equal to 0.01", product.errors[:price].join('; ')
    product.price = 0
    assert product.invalid?
    assert_equal "must be greater than or equal to 0.01", product.errors[:price].join('; ')
    product.price = 1
    assert product.valid?
  end

  test "image url" do
    ok = %w{ first.jpg second.png gif.gif SoMe.Jpg SOME.PNG http://a/a/a/a/g/g/g/.gif }
    bad = %w{ bad.bad some.doc png.lol gif.fig }
    ok.each { |okay_url| assert new_product(okay_url).valid?, "#{okay_url} should be valid." }
    bad.each { |bad_url| assert new_product(bad_url).invalid?, "#{bad_url} should be invalid." }
  end

  test 'product is not valid without a unique title' do
    product = Product.new( title: products(:first_cat).title,
                            description: 'cat',
                            image_url: 'cat2.jpg',
                            price: 1)
    assert !product.save
    assert_equal I18n.translate('activerecord.errors.messages.taken'), product.errors[:title].join('; ')
  end

  test 'product title length must be 5 or more' do
    four_symbols = 'four'
    five_symbols = 'five5'
    six_symbols = 'sixsix'
    assert new_product_with_title(four_symbols).invalid?
    assert new_product_with_title(five_symbols).valid?
    assert new_product_with_title(six_symbols).valid?
  end

  private

  def new_product(image_url)
    Product.new(title: 'some title',
                description: 'some description',
                image_url: image_url,
                price: 1)
  end

  def new_product_with_title(title)
    Product.new(title: title,
                description: 'some description',
                image_url: 'cat2.jpg',
                price: 1)
  end
end
