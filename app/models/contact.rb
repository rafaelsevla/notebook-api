class Contact < ApplicationRecord
  belongs_to :kind
  has_many :phones
  has_one :address

  accepts_nested_attributes_for :phones, allow_destroy: true
  accepts_nested_attributes_for :address

  def as_json(options = {})
    hash = super(options)
    hash[:birthdate] = I18n.l(self.birthdate)
    hash
  end

  def to_i18n
    {
      name: self.name,
      email: self.email,
      birthdate: I18n.l(self.birthdate)
    }
  end
end
