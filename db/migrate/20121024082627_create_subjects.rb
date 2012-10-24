class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.string :pointer

      t.timestamps
    end
  end
end
