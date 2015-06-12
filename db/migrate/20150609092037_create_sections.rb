class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|

      t.belongs_to  :user, class_name: "UsersEngine::User", null: false
      t.decimal  "distance",      null: false
      t.decimal  "duration",      null: false
      t.string   "start_address", null: false, limit: 50
      t.string   "end_address",   null: false, limit: 50

      t.timestamps null: false
    end
  end
end
