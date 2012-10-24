class MoveParticipantAndPointerToAnotherModel < ActiveRecord::Migration
  def up
    remove_column :trials, :participant
    remove_column :trials, :pointer
  end

  def down
    add_column :trials, :participant, :string, :default => "participant"
    add_column :trials, :pointer, :string, :default => "pointer"
  end
end
