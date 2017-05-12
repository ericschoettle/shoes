class Store < ActiveRecord::Base
  has_many :joins
  has_many :brands, through: :joins
end
