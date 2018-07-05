class Item
  include Mongoid::Document
  embedded_in :section, inverse_of: :items
  field :content, type: Hash
end
