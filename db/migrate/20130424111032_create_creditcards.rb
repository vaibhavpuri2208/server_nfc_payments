class CreateCreditcards < ActiveRecord::Migration
  def change
    create_table :creditcards do |t|
      t.integer :card_number
      t.string :card_holder_name
      t.datetime :expiration_date
      t.integer :cvv

      t.timestamps
    end
  end
end
