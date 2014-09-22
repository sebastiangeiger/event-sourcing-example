class CreateAccountEvents < ActiveRecord::Migration
  def change
    create_table :account_events do |t|
      t.date :date
      t.string :sender_receiver
      t.string :description
      t.float  :amount
      t.string :type
      t.references :account

      t.timestamps
    end
  end
end
