FactoryGirl.define do
  factory :book do
    name { Faker::Lorem.sentence 5 }
    content { Faker::Lorem.paragraph }
    author
  end

  factory :invalid_book, parent: :book do
  	name nil
  	content nil
  	author nil
  end
end
