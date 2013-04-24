class Credit < ActiveRecord::Base
  attr_accessible :amount, :customer_id
end
