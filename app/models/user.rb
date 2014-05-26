class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :token_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates_presence_of :name

  has_many :records
  has_many :categories

  def not_empty_categories
    begin
      categories.where(:id => records.pluck(:category_id))
    rescue
      Array.new
    end
  end
end
