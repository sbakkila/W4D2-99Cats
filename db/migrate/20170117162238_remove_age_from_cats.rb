class RemoveAgeFromCats < ActiveRecord::Migration
  def change
    remove_column :cats, :age
  end
end
