class AddColumnsLatDirectionLongDirectionToLocation < ActiveRecord::Migration[6.1]
  def change
    add_column :locations, :lat_direction, :integer, default: 1
    add_column :locations, :long_direction, :integer, default: 1
  end
end
