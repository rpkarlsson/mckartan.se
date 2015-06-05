# This migration comes from users_engine (originally 20150527175139)
class CreateUsersEngineUsers < ActiveRecord::Migration
  def change
    create_table :users_engine_users do |t|
      t.string :name
      t.string :email
      t.string :password_digest

      t.timestamps null: false
    end
  end
end
