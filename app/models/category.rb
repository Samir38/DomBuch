class Category < ActiveRecord::Base
  validates_presence_of :name, :user_id
  belongs_to :user
  has_many :records
end
