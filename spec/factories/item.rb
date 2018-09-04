FactoryBot.define do
  factory :item do
    section
    text # Defaults to a text item if the trait is not specified

    trait :text do
      type :text
      sequence(:content) { |n| "Item text #{n}" }
    end

    trait :image do
      type :image
      sequence(:content) { |n| "https://example.com/image#{n}.png" }
    end
  end
end
