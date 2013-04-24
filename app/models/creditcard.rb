class Creditcard < ActiveRecord::Base
  attr_accessible :card_holder_name, :card_number, :cvv, :expiration_date
end
