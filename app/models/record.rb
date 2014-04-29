class Record < ActiveRecord::Base

  validates_presence_of :desc, :sum
  validates_numericality_of :sum

  belongs_to :user
  belongs_to :category

  def category_name
    category ? category.name : nil
  end

  def self.filter_by_category(records, category)
    if category
      records.where(category: Category.find_by(name: category))
    else
      records.all
    end
  end

end
