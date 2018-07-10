class Item
  include Mongoid::Document
  include ActiveModel::Validations

  embedded_in :section, inverse_of: :items

  field :content, type: Hash
  validates :content, presence: true
end
