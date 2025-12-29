class Contact < ApplicationRecord
  belongs_to :kind
  has_many :phones

  def to_i18n
    {
      name: self.name,
      email: self.email,
      birthdate: I18n.l(self.birthdate)
    }
  end
end
