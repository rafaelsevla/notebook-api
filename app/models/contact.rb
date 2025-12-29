class Contact < ApplicationRecord
  belongs_to :kind
  has_many :phones
  accepts_nested_attributes_for :phones, allow_destroy: true

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
