class CreatePointOfInterests < ActiveRecord::Migration[5.2]
  def change
    create_table :point_of_interests do |t|
      t.belongs_to  :user, class_name: "UsersEngine::User", null: false
      t.float :lng
      t.float :lat
      t.timestamps null: false
    end
  end
end
