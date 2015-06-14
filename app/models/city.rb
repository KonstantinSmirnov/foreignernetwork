class City < ActiveRecord::Base

  belongs_to :country
  has_many :users

  validates :cityname, presence: true
end
