namespace :dev do
  desc "Setup development environment"
  task setup: :environment do
    %x(rails db:migrate:reset)
    puts "Database reset successfully"

    kinds = %w[Amigo Comercial Familiar Conhecido]
    kinds.each do |kind|
      Kind.create!(description: kind)
    end
    puts "Kind of contacts registered successfully"

    100.times do |i|
      Contact.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        birthdate: Faker::Date.between(from: 65.years.ago, to: 18.years.ago),
        kind: Kind.all.sample
      )
    end
    puts "Contacts registered successfully"

    Contact.all.each do |contact|
      Random.rand(5).times do |i|
        Phone.create!(number: Faker::PhoneNumber.cell_phone, contact: contact)
      end
    end
    puts "Phones registered successfully"

    Contact.all.each do |contact|
      Address.create!(
        street: Faker::Address.street_address,
        city: Faker::Address.city,
        contact: contact
      )
    end
    puts "Addresses registered successfully"
  end
end
