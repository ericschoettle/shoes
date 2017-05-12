class Brand < ActiveRecord::Base
  has_many :joins, dependent: :destroy
  has_many :stores, through: :joins

  validates :name, uniqueness: { case_sensitive: false }
  validates :name, length: { maximum: 100, too_long: "100 characters is the maximum allowed" }
  validates :name, presence: true

  before_save(:capitalize_words)

  def not_stores
    not_stores = Store.all() - self.stores()
  end

private
  def capitalize_words
    binding.pry
    caps = self.name().split(' ').map(&:capitalize).join(' ')
  end

end
