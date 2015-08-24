class AddPrivacyToGoals < ActiveRecord::Migration
  def change
    add_column :goals, :privacy, :string, default: "Public"
  end
end
