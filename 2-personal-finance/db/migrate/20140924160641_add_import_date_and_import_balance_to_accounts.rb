class AddImportDateAndImportBalanceToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :import_date, :date
    add_column :accounts, :import_balance, :float
  end
end
