FactoryBot.define do
  factory :profile do
    sequence(:name) { |n| "Profile name #{n}" }
    user

    trait :filled_with_content do
      after(:create) do |profile|
        4.times do
          create(:section, :filled_with_content, profile: profile)
        end
      end
    end
  end
end
