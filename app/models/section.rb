class Section
  include Mongoid::Document
  include ActiveModel::Validations

  embedded_in :profile, inverse_of: :sections
  embeds_many :items

  field :name, type: String
  validates :name, presence: true
end
