class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.string :desc
      t.integer :sum
      t.date :date
      t.string :kind

      t.timestamps
    end
  end
end
