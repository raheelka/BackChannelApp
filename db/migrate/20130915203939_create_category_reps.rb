class CreateCategoryReps < ActiveRecord::Migration
  def change
    create_table :category_reps do |t|
      t.string :category

      t.timestamps
    end
  end
end
