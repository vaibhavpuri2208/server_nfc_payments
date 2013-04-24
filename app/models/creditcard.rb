class Creditcard < ActiveRecord::Base
  validates :card_number, :numericality => true


  attr_accessible :card_holder_name, :card_number, :cvv, :expiration_date, :expiration_month, :expiration_year, :billing_address, :customer_id

end


