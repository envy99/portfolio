class Section
  include Mongoid::Document
  embedded_in :profile, inverse_of: :sections
  embeds_many :items
  field :name, type: String
end
