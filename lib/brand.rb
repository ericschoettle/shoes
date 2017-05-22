class Brand < ActiveRecord::Base
  has_many :joins, dependent: :destroy
  has_many :stores, through: :joins

  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }
  validates :name, length: { maximum: 100, too_long: "100 characters is the maximum allowed" }
  validates :price, presence: true

  validates :name, presence: true, on: :update
  validates :name, uniqueness: { case_sensitive: false }, on: :update
  validates :name, length: { maximum: 100, too_long: "100 characters is the maximum allowed" }, on: :update
  validates :price, presence: true, on: :update

  before_save(:capitalize_words)
  before_save(:convert_to_cents)

  def not_stores
    not_stores = Store.all() - self.stores()
  end

  def to_money
    string = "$" + self.price.to_s()
    return string.insert(-3, ".")
  end

  private
  def capitalize_words
    self.name = name.split(' ').map(&:capitalize).join(' ')
  end

  def convert_to_cents
    string = price.to_s
    string.tr!("$", "")
    string.tr!(",", "")
    if string.include?(".")
      string.tr!(".", "")
      self.price = string.to_i()
    else
      self.price = string.to_i() * 100
    end
  end
end
