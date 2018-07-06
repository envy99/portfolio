class Profile
  include Mongoid::Document
  include ActiveModel::Validations
  embedded_in :user, inverse_of: :profile
  embeds_many :sections
  field :name, type: String
  validates :name, presence: true
end
