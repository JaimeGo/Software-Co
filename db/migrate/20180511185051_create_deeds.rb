class CreateDeeds < ActiveRecord::Migration[5.0]
  def change
    create_table :deeds do |t|
      t.string :identifier
      t.integer :state, default: 0
      t.date :start_date
      t.integer :duration
      t.references :real_estate
      # t.references :lawyer
      t.timestamps
    end
  end
end
