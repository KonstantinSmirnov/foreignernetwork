class Post < ActiveRecord::Base
  belongs_to :user, :class_name => "User", :foreign_key => 'user_id'
  belongs_to :author, :class_name => "User", :foreign_key => 'author_id'

  validates :user_id, presence: true
  validates :text, presence: true
  validates :author_id, presence: true
end
