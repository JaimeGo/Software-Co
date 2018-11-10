class CreateJoinTableDeedUser < ActiveRecord::Migration[5.0]
  def change
    create_join_table :deeds, :users do |t|
      t.index [:deed_id, :user_id]
      # t.index [:user_id, :deed_id]
    end
  end
end
