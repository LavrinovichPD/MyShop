class PayType < ActiveRecord::Base
  has_many :order
  validates :name, presence: true
end
