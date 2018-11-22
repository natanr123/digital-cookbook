require 'test_helper'

class RecipeTest < ActiveSupport::TestCase

  def test_attributes
    assert Recipe.attribute_names.include? "cuisine"
    assert Recipe.attribute_names.include? "name"
    assert Recipe.attribute_names.include? "instructions"
    assert Recipe.attribute_names.include? "cooking_time"
  end

  def test_name_must_be_present
    recipe = Recipe.new name: " "
    assert recipe.invalid?
    assert recipe.errors.include?(:name)
  end

  def test_name_must_not_be_longer_than_100_characters
    recipe = Recipe.new name: "a" * 101
    recipe.validate
    assert recipe.errors.include?(:name)
    recipe.name = "a" * 100
    recipe.validate
    assert !recipe.errors.include?(:name)
  end

  def test_instructions_must_be_present
    recipe = Recipe.new instructions: " "
    assert recipe.invalid?
    assert recipe.errors.include?(:instructions)
  end

  def test_instructions_must_not_be_longer_than_1000_characters
    recipe = Recipe.new instructions: "a" * 1001
    recipe.validate
    assert recipe.errors.include?(:instructions)
    recipe.instructions = "a" * 1000
    recipe.validate
    assert !recipe.errors.include?(:instructions)
  end

  def test_cooking_time_must_be_present
    recipe = Recipe.new cooking_time: nil
    assert recipe.invalid?
    assert recipe.errors.include?(:cooking_time)
  end

  def test_negative_cooking_time_is_incorrect
    recipe = Recipe.new cooking_time: -5
    assert recipe.invalid?
    assert recipe.errors.include?(:cooking_time)
  end

  def test_zero_cooking_time_is_incorrect
    recipe = Recipe.new cooking_time: 0
    assert recipe.invalid?
    assert recipe.errors.include?(:cooking_time)
  end

end
