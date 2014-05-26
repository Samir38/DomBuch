class Category < ActiveRecord::Base
  validates_presence_of :name, :user_id
  belongs_to :user
  has_many :records
  def to_param
    name
  end

  def not_empty

  end
end
