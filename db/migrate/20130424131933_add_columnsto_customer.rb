class AddColumnstoCustomer < ActiveRecord::Migration
  def change
    add_column :creditcards, :expiration_month, :integer
    add_column :creditcards, :expiration_year, :integer
    add_column :creditcards, :billing_address, :string
  end

end
