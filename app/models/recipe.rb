class Recipe < ActiveRecord::Base

  has_many :ingredients, inverse_of: :recipe
  validates :instructions, presence: true, allow_blank: false
  validates :cooking_time, :numericality => { greater_than: 0 }
  validates :name, presence: true, allow_blank: false
  validates_length_of :name, maximum: 100
  validates_length_of :instructions, maximum: 1000





end
