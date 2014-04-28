class AddRelationsBetweenRecordsAndCategories < ActiveRecord::Migration
  def change
    add_column :records, :category_id, :integer
  end
end
