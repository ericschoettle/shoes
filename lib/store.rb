class Store < ActiveRecord::Base
  has_many :joins
  has_many :brands, through: :joins

  def not_brands
    return not_brands = Brand.all() - self.brands()
  end
end
