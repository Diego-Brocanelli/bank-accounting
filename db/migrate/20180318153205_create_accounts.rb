class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.string :user_name
      t.string :number
      t.decimal :balance

      t.timestamps
    end
  end
end
