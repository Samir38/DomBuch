class AddRelationsBetweenUserAndRecord < ActiveRecord::Migration
  def change
    change_table :records do |t|
      t.belongs_to :user
    end
  end
end
