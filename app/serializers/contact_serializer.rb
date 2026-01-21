class ContactSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :birthdate

  belongs_to :kind do
    link(:kind) { kind_url(object.kind.id) }
  end

  has_many :phones
  has_one :address

  link(:self) { contact_url(object.id) }

  meta do
    { something: "Anything" }
  end

  def attributes(*args)
    hash = super(*args)
    hash[:birthdate] = object.birthdate.to_time.iso8601 unless object.birthdate.blank?
    hash
  end
end
