class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :user_id
      t.integer :recepient_id
      t.string :message
      t.boolean :read

      t.timestamps null: false
    end
  end
end
