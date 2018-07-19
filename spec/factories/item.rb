FactoryBot.define do
  factory :item do
    section
    text # Defaults to a text item if the trait is not specified

    trait :text do
      type :text
      content "Item text"
    end

    trait :image do
      type :image
      content "https://example.com/image.png"
    end
  end
end
