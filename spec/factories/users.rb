FactoryBot.define do

  factory :user, class: User do
    name { "Example user" }
    email { "user@example.com" }
    password { "foobar" }
    password_confirmation { "foobar" }
    admin { false }

    factory :other_user do
      name { Faker::Name.name }
      email { Faker::Internet.email }
    end

    factory :admin do
      name { Faker::Name.name }
      email { Faker::Internet.email }
      admin { true }
    end
  end

end
