require 'test_helper'

class IngredientTest < ActiveSupport::TestCase

  def test_attributes
    assert Ingredient.attribute_names.include? "name"
  end

  def test_name_must_be_present
    ingredient = Ingredient.new name: " "
    assert ingredient.invalid?
    assert ingredient.errors.include?(:name)
  end

  def test_name_must_not_be_longer_than_100_characters
    ingredient = Ingredient.new name: "a" * 101
    ingredient.validate
    assert ingredient.errors.include?(:name)
    ingredient.name = "a" * 100
    ingredient.validate
    assert !ingredient.errors.include?(:name)
  end

end
