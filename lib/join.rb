class Join < ActiveRecord::Base
  belongs_to :brands
  belongs_to :stores
end
