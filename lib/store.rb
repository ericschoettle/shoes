class Store < ActiveRecord::Base
  has_many :joins, dependent: :destroy
  has_many :brands, through: :joins

  validates :name, uniqueness: { case_sensitive: false }
  validates :name, length: { maximum: 100, too_long: "100 characters is the maximum allowed" }
  validates :name, presence: true

  before_save(:capitalize_words)

  def not_brands
    return not_brands = Brand.all() - self.brands()
  end

  private
    def capitalize_words
      binding.pry
      self.name = name.split(' ').map(&:capitalize).join(' ')
    end

end
