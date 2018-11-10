class CreateSteps < ActiveRecord::Migration[5.0]
  def change
    create_table :steps do |t|
      t.references :user, foreign_key: true
      t.references :deed, foreign_key: true
      t.datetime :executed_on
      t.integer :state

      t.timestamps
    end
  end
end
