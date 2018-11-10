
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # has_and_belongs_to_many :deeds
  has_many :deeds
  has_many :real_estate_deeds, class_name: 'Deed', foreign_key: 'real_estate_id'
  has_and_belongs_to_many :lawyer_deeds, class_name: 'Deed', join_table: 'deeds_users', foreign_key: 'user_id'
  # has_and_belongs_to_many :studying_schools, :class_name => "School", :join_table => "schools_students", :foreign_key => "student_id"
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  enum job: [:inmobiliaria, :abogado, :cliente]

  def deeds
    real_estate_deeds + lawyer_deeds
  end

  def full_name
    first_name + ' ' + last_name
  end
end
