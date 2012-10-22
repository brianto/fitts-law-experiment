class CreateTrials < ActiveRecord::Migration
  def change
    create_table :trials do |t|
      t.decimal :time
      t.decimal :distance
      t.decimal :size
      t.string :pointer
      t.string :participant

      t.timestamps
    end
  end
end
