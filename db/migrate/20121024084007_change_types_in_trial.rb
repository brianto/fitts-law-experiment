class ChangeTypesInTrial < ActiveRecord::Migration
  def up
    change_column :trials, :distance, :string, :default => "distance"
    change_column :trials, :size, :string, :default => "size"
    change_column :trials, :time, :integer
  end

  def down
    change_column :trials, :distance, :decimal, :default => 0
    change_column :trials, :size, :decimal, :default => 0
    change_column :trials, :time, :decimal
  end
end
