FactoryBot.define do

  factory :user, class: User do
    name { "Example user" }
    email { "user@example.com" }
    password { "foobar" }
    password_confirmation { "foobar" }
    admin { false }

    factory :other_user do
      name { "other_user" }
      email { Faker::Internet.email }
    end

    factory :admin do
      name { "admin_user" }
      email { "admin@example.com" }
      admin { true }
    end
  end

end
