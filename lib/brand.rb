class Brand < ActiveRecord::Base
  has_many :joins, dependent: :destroy
  has_many :stores, through: :joins

  def not_stores
    all_stores = Store.all()
    brand_stores = self.stores()
    not_stores = all_stores - brand_stores
  end
end
