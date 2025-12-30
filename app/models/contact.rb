class Contact < ApplicationRecord
  belongs_to :kind
  has_many :phones
  has_one :address

  accepts_nested_attributes_for :phones, allow_destroy: true
  accepts_nested_attributes_for :address

  def as_json(options = {})
    hash = super(options)
    hash["birthdate"] = I18n.l(self.birthdate) if self.birthdate.present?
    hash
  end
end
