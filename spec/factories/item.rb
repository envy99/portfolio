FactoryBot.define do
  factory :item do
    section
    text # Defaults to a text item if the trait is not specified

    trait :text do
      content({ type: :text, body: "Text body" })
    end

    trait :image do
      content({ type: :image, source: "https://example.com/image.png" })
    end
  end
end
