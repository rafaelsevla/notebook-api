namespace :dev do
  desc "Setup development environment"
  task setup: :environment do
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
  end
end
