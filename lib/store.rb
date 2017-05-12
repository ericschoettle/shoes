class Store < ActiveRecord::Base
  has_many :joins, dependent: :destroy
  has_many :brands, through: :joins
  validates :name, uniqueness: { case_sensitive: false }
  validates :name, length: { maximum: 100, too_long: "100 characters is the maximum allowed" }
  validates :name, presence: true

  def not_brands
    return not_brands = Brand.all() - self.brands()
  end
end

# :length => { :maximum => 100 },
