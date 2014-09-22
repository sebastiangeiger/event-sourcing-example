class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :institution
      t.string :number
      t.float :cached_balance, default: 0

      t.timestamps
    end
  end
end
