class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :front
      t.string :back
      t.references :box, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
