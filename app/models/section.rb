class Section
  include Mongoid::Document
  include ActiveModel::Validations

  embedded_in :profile, inverse_of: :sections
  embeds_many :items

  accepts_nested_attributes_for :items, reject_if: :all_blank, allow_destroy: true

  field :name, type: String
  validates :name, presence: true
end
