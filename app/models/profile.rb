class Profile
  include Mongoid::Document
  embedded_in :user, inverse_of: :profile
  embeds_many :sections
  field :name, type: String
end
