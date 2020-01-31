FactoryBot.define do
  factory :user do
    name { "Test User" }
    #email { 'Testexample@email.com' }
    sequence(:email) { |n| "user_#{n}@example.com"}
    password { "password" }
    password_confirmation { "password" }
    admin { false }
    factory :user_with_microposts do
      after(:create) do |user|
        create(:micropost, user: user)
      end
    end
  end

  factory :admin_user, class: User do
    name { "Admin user" }
    email { "admin@example.com" }
    password { "password" }
    password_confirmation { "password" }
    admin { true }
  end

  factory :other_user, class: User do
    name { "Other User"}
    email { "other@example.com" }
    password { "foobar" }
    password_confirmation { "foobar" }
  end

  factory :other_user2, class: User do
    name { "Other2 User"}
    email { "other2@example.com" }
    password { "foobar" }
    password_confirmation { "foobar" }
  end

end
