class Brand < ActiveRecord::Base
  has_many :joins, dependent: :destroy
  has_many :stores, through: :joins

  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }
  validates :name, length: { maximum: 100, too_long: "100 characters is the maximum allowed" }
  # validates :price, presence: true

  # before_save(:capitalize_words)
  # before_save(:convert_to_cents)

  def not_stores
    not_stores = Store.all() - self.stores()
  end

  # def convert_to_money(cents)
  #   string = "$" + cents.to_s()
  #   return string.insert(-3, ".")
  # end

# private
#   def capitalize_words
#     self.name = name.split(' ').map(&:capitalize).join(' ')
#   end

  # def convert_to_cents
  #   price.tr!("$", "")
  #   if price.include?(".")
  #     price.tr!(".", "")
  #     self.price = price.to_i()
  #   else
  #     self.price = price.to_i() * 100
  #   end
  # end

end
