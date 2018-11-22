class Ingredient < ActiveRecord::Base

  belongs_to :recipe, inverse_of: :ingredients
  validates :name, presence: true, allow_blank: false
  validates_length_of :name, maximum: 100

end
