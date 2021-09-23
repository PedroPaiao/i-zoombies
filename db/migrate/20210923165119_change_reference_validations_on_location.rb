class ChangeReferenceValidationsOnLocation < ActiveRecord::Migration[6.1]
  def change
    remove_reference :locations, :survivor

    add_reference :locations, :survivor
    add_foreign_key :locations, :survivors, on_delete: :cascade
  end
end
