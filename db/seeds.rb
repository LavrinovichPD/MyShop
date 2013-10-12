# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Order.delete_all
PayType.delete_all

PayType.create(name: 'Check')
PayType.create(name: 'Credit')
PayType.create(name: 'Purchase')
Order.transaction do
  1000.times do
    Order.create   name: 'Some Name',
                   address: 'Some Address',
                   email: 'some@ema.il',
                   pay_type: PayType.find_by_name('Check')
  end
end
