class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|

      t.integer  "user_id",       null: false
      t.decimal  "distance",      null: false
      t.decimal  "duration",      null: false
      t.string   "start_address", null: false, limit: 50
      t.string   "end_address",   null: false, limit: 50

      t.timestamps null: false
    end

    add_index "sections", ["user_id"], name: "index_sections_on_user_id"
  end
end
