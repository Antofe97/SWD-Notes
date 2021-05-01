class AddColumnToNotes < ActiveRecord::Migration[6.1]
  def change
    add_reference :notes, :collection, foreign_key: true
  end
end
