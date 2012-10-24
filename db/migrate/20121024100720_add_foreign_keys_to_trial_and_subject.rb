class AddForeignKeysToTrialAndSubject < ActiveRecord::Migration
  def change
    add_column :trials, :subject_id, :integer
    add_index :trials, :subject_id
  end
end
