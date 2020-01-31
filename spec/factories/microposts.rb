FactoryBot.define do
  factory :micropost do
    content { "MyText" }
    user_id { user.id }
    user
  end

  factory :microposts, class: Micropost do
    trait :micropost1 do
      content { "TT兄弟" }
      user_id { 1 }
      created_at { 5.minutes.ago }
    end

    trait :micropost2 do
      content { "PP兄弟" }
      user_id { 1 }
      created_at { 5.hours.ago }
    end

    trait :micropost3 do
      content { "QQ兄弟" }
      user_id { 1 }
      created_at { Time.zone.now }
    end
    association :user, factory: :user
  end

end
