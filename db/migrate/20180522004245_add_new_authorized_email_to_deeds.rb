class AddNewAuthorizedEmailToDeeds < ActiveRecord::Migration[5.0]
  def change
    add_column :deeds, :new_authorized_email, :string
  end
end
