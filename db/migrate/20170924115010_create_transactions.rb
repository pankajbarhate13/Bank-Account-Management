class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :account_id
      t.decimal :balance, precision: 8, scale: 2, :default=>0.0 
      t.integer :sender_account_id
      t.integer	:reciever_account_id
      t.decimal :deposite_amount, precision: 8, scale: 2, :default=>0.0
      t.decimal :withdraw_amount, precision: 8, scale: 2, :default=>0.0
      t.decimal :transfer_amount, precision: 8, scale: 2, :default=>0.0

      t.timestamps null: false
    end
  end
end
