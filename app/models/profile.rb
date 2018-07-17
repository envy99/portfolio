class Profile
  include Mongoid::Document
  include ActiveModel::Validations

  belongs_to :user, inverse_of: :profile
  embeds_many :sections

  accepts_nested_attributes_for :sections, reject_if: :all_blank, allow_destroy: true

  field :name, type: String
  validates :name, presence: true

  def belongs_to?(owner)
    user == owner
  end
end
