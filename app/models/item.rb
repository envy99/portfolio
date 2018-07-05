class Item
  include Mongoid::Document
  field :content, type: Hash
end
