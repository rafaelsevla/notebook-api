namespace :dev do
  desc "Setup development environment"
  task setup: :environment do
    puts "Resetting database..."
    %x(rails db:migrate:reset)

    puts "Registering kinds..."
    kinds = %w[Amigo Comercial Familiar Conhecido]
    kinds.each { |kind| Kind.create!(description: kind) }

    puts "Registering contacts with addresses..."
    100.times do
      Contact.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        birthdate: Faker::Date.between(from: 65.years.ago, to: 18.years.ago),
        kind: Kind.all.sample,
        # Aqui está a mágica: criamos o endereço junto com o contato
        address_attributes: {
          street: Faker::Address.street_address,
          city: Faker::Address.city
        }
      )
    end

    puts "Registering phones..."
    Contact.all.each do |contact|
      Random.rand(5).times do
        Phone.create!(number: Faker::PhoneNumber.cell_phone, contact: contact)
      end
    end

    puts "Everything set up successfully!"
  end
end
