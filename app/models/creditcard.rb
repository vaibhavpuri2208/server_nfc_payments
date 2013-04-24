class Creditcard < ActiveRecord::Base
  validates :card_number, :numericality => true #, :length => {is:16}
  validates :cvv, :numericality => true #, :length => {is:3}
  validates :expiration_month, :numericality => true #, :length => {is:2}
  validates :expiration_year, :numericality => true #, :length => {is:4}
  validates :billing_address, :presence => true
  attr_accessible :card_holder_name, :card_number, :cvv, :expiration_date, :expiration_month, :expiration_year, :billing_address, :customer_id
end


