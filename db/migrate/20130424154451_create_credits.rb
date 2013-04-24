class CreateCredits < ActiveRecord::Migration
  def change
    create_table :credits do |t|
      t.integer :amount
      t.integer :customer_id

      t.timestamps
    end
  end
end
