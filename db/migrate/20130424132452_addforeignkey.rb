class Addforeignkey < ActiveRecord::Migration
  def change
    add_column :creditcards, :customer_id, :integer

  end


end
