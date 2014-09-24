class CreateAccountSnapshots < ActiveRecord::Migration
  def change
    create_table :account_snapshots do |t|
      t.references :account, index: true
      t.float :balance
      t.date :date
      t.references :predecessor, index: true

      t.timestamps
    end
  end
end
