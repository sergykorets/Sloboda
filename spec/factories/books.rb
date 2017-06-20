FactoryGirl.define do
  factory :book do
  	author_name { Faker::Name.name }
    name { Faker::Lorem.sentence 5 }
    content { Faker::Lorem.paragraph }
    author
  end
end
