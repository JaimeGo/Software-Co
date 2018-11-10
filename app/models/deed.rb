
class Deed < ApplicationRecord
  # has_one :real_estate, class_name: "User"#, foreign_key: :real_estate_id
  belongs_to :real_estate, class_name: 'User'
  has_and_belongs_to_many :lawyers, class_name: 'User', join_table: 'deeds_users', foreign_key: 'deed_id'
  # , optional: true # , foreign_key: :lawyer_id

  # has_many :real_estate_deeds, class_name: 'Deed', foreign_key: 'real_estate_id'
  # has_and_belongs_to_many :lawyer_deeds, class_name: 'Deed', join_table: 'deeds_users', foreign_key: 'user_id'
  # # belongs_to :shipping_address, :class_name => 'Address'
  # has_many :users

  has_many :steps, dependent: :destroy
  enum state: [
    'Enviado a notaría',
    'Firma cliente',
    'Firma inmobiliaria',
    'Enviado a banco alzante',
    'Copiado abogado',
    'Cotización conservador',
    'Carátula conservador',
    'Envío a inmobiliaria',
  ]

  def ended
    return true if steps.order('created_at').last && steps.order('created_at').last.state == 'Envío a inmobiliaria'
    false
  end

  def days_left
    return nil if start_date.blank?
    a = duration + (start_date - Date.today).to_i
    return a if a > 0
    0
  end

  def lawyer
    lawyers[0]
  end

  def less_than_twenty
    # p ended
    return days_left < 20 unless start_date.nil? || ended
    false
  end

  def expiration_date
    # Time.at(start_date)
    return nil if start_date.blank?
    start_date + duration
  end
  # before_validation :find_lawyer

  # private
  #   def find_lawyer
  #     self.lawyer = User.find_by(email: self.lawyer_id)
  #   end
end
