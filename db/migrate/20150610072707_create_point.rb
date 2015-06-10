class CreatePoint < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.integer :section_id, null: false
      t.float :lng
      t.float :lat
    end
    add_index "points", ["section_id"], name: "index_points_on_section_id"
  end
end
