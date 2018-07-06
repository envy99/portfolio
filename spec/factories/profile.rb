FactoryBot.define do
  factory :profile do
    sequence(:name) { |n| "Profile name #{n}" }
    user
  end
end
