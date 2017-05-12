class Brand < ActiveRecord::Base
  has_many :joins, dependent: :destroy
  has_many :stores, through: :joins
  validates :name, uniqueness: { case_sensitive: false }
  validates :name, length: { maximum: 100, too_long: "100 characters is the maximum allowed" }
  validates :name, presence: true

  def not_stores
    all_stores = Store.all()
    brand_stores = self.stores()
    not_stores = all_stores - brand_stores
  end
end

# :length => { :maximum => 100 },
