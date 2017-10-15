class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.integer :user_id
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :phone
      t.string :email

      t.timestamps null: false
    end
  end
end
