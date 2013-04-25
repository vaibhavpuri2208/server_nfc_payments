class Credit < ActiveRecord::Base
  validates :customer_id, :uniqueness=>true
  attr_accessible :amount, :customer_id
end
