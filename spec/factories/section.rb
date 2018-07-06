FactoryBot.define do
  factory :section do
    sequence(:name) { |n| "Section name #{n}" }
    profile
  end
end
