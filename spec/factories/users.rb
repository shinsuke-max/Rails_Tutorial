FactoryBot.define do
  factory :user do
    name { "Test User" }
    sequence(:email) { |n| "user_#{n}@example.com"}
    password { "password" }
    password_confirmation { "password" }
    admin { true }
    activated { true }
    activated_at { Time.zone.now }
  end

  factory :other_user, class: User do
    name { "Other User"}
    email { "other@example.com" }
    password { "foobar" }
    password_confirmation { "foobar" }
    activated { true }
    activated_at { Time.zone.now }
  end

  factory :other_user2, class: User do
    name { "Other2 User"}
    email { "other2@example.com" }
    password { "foobar" }
    password_confirmation { "foobar" }
    activated { true }
    activated_at { Time.zone.now }
  end

end
