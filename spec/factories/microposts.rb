FactoryBot.define do
  factory :user_post, class: Micropost do
    content { Faker::Lorem.sentence(5) }
    association :user, factory: :user

    factory :other_user_post do
      content { Faker::Lorem.sentence(5) }
      association :user, factory: :other_user
    end
  end

end
