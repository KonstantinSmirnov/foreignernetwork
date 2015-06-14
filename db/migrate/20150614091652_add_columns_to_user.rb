class AddColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :country_id, :integer
    add_column :users, :city_id, :integer
    add_column :users, :username_id, :integer
    add_column :users, :userlastname_id, :integer
    add_column :users, :gender_id, :integer
    add_column :users, :relationship_id, :integer
    add_column :users, :birthdate, :date
  end
end
