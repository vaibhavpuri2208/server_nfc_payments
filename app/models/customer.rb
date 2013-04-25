class Customer < ActiveRecord::Base

  validates :email, :uniqueness => {:message => "Email already exists" }
  attr_accessible :email, :name, :password_digest

  has_one :creditcard
 end
