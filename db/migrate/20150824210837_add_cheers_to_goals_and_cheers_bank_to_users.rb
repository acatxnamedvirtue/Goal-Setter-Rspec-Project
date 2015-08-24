class AddCheersToGoalsAndCheersBankToUsers < ActiveRecord::Migration
  def change
    add_column :users, :cheers_bank, :integer, null: false, default: 10
    add_column :goals, :cheers_value, :integer, null: false, default: 0
  end
end
