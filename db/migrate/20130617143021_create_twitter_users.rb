class CreateTwitterUsers < ActiveRecord::Migration
  def change
    create_table :twitter_users do |t|
      t.string :screen_name
      t.timestamps
    end
  end
end
