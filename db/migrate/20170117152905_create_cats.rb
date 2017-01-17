class CreateCats < ActiveRecord::Migration
  def change
    create_table :cats do |t|
      t.date :birth_date, null: false
      t.integer :age
      t.string :color
      t.string :name, null: false
      t.string :sex, limit: 1
      t.text :description
    end
  end
end
