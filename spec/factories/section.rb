FactoryBot.define do
  factory :section do
    sequence(:name) { |n| "Section name #{n}" }
    profile

    trait :filled_with_content do
      after(:create) do |section|
        Item::TYPES.each do |type|
          create(:item, type, section: section)
        end
      end
    end
  end
end
