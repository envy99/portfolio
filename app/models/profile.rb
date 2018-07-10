class Profile
  include Mongoid::Document
  include ActiveModel::Validations

  belongs_to :user, inverse_of: :profile
  embeds_many :sections

  field :name, type: String
  validates :name, presence: true
end
