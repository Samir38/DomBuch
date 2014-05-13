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

  def self.user_summary(user)
    plus = connection.execute(
        <<-SQL
          SELECT SUM(sum) AS sum
          FROM records WHERE kind = 'Доход'
          AND user_id=#{user.id}
        SQL
        ).first['sum']
    minus = connection.execute(
        <<-SQL
          SELECT SUM(sum) AS sum
          FROM records WHERE kind = 'Расход'
          AND user_id=#{user.id}
        SQL
        ).first['sum']
    plus.to_i - minus.to_i
  end

end
