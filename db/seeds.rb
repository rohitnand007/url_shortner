# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
["https://fb.com","https://google.com","https://quora.com","https://twitter"].each do |url|
    clicks = rand(2..10)
    url = Url.create(original_url:url,short_url:Url.generate_short_url,clicks_count:clicks)
    clicks.times do
        url.clicks.create(browser:["Chrome","Firefox","Generic"].sample,platform:["Linux","Windows","Other"].sample,created_at:rand(2..10).days.ago,updated_at:rand(2..10).days.ago)
    end
end    