class Item
  TYPES = %i(text image).freeze

  include Mongoid::Document
  include ActiveModel::Validations

  embedded_in :section, inverse_of: :items

  field :type, type: Symbol
  field :content, type: String

  validates :type, :content, presence: true
  validates :type, inclusion: { in: TYPES }

  TYPES.each do |type_name|
    define_method :"#{type_name}?" do
      type == type_name
    end
  end
end
