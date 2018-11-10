class Step < ApplicationRecord
  belongs_to :user
  belongs_to :deed

  validates_uniqueness_of :deed_id, scope: :state

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
  # enum state: [
  #   :in_notary,
  #   :client_sign,
  #   :real_estate_sign,
  #   :copied_bank,
  #   :copied_lawyer,
  #   :deed_quote,
  #   :numbered,
  #   :in_real_estate,
  #   :inscribed
  # ]
end
