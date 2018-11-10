class AddUniqueConstraints < ActiveRecord::Migration[5.0]
  def change
    add_index :steps, [:deed_id, :state], unique: true
    add_index :deeds, [:real_estate_id, :identifier], unique: true
  end
end
