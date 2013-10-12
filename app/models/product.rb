class Product < ActiveRecord::Base
  has_many :line_items
  has_many :orders, through: :line_items
  validates :title, :description, :image_url, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true, format: {
    with: %r{\.(gif|jpg|png)\z}i,
    message: 'Only GIF, JPG and PNG formats are supported.'
  }
  validates :title, length: { minimum: 5 }


  before_destroy :ensure_no_line_items

  private

  def ensure_no_line_items
    if line_items.empty?
      true
    else
      errors.add(:base, 'line items was founded.')
      false
    end

  end

end
