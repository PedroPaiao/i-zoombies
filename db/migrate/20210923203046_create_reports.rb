class CreateReports < ActiveRecord::Migration[6.1]
  def change
    create_table :reports do |t|
      t.string :description      
      t.references :whistleblower_survivor, foreign_key: { to_table: 'survivors' }, on_delete: :cascade
      t.references :reported_survivor, foreign_key: { to_table: 'survivors' }, on_delete: :cascade

      t.timestamps
    end
  end
end
