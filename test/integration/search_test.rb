require 'test_helper'

class SearchTest < ActionDispatch::IntegrationTest

  def test_search_form_should_have_search_fields
    visit "/"
    assert find_field("Cuisine")
    assert find_field("Ingredient")
    assert find_button("Search")
  end

  def test_search_by_cuisine
    visit "/"
    fill_in "Cuisine", with: "Polish"
    click_on "Search"

    # Finds correct recipes
    assert page.has_text? "Pierogi"
    assert page.has_no_text? "Carbonarra"
    assert page.has_no_text? "Sandwich"
    assert page.has_no_text? "Pizza"

    # Display associated ingredients
    assert page.has_text? "Flour"
    assert page.has_no_text? "Eggs"

    # Display instructions
    assert page.has_text? "Make stuffing from cheese, potatoes and onion."
    assert page.has_no_text? "Cook spaghetti in the pot."

    # Displays cooking time
    assert page.has_text? "120 min"
    assert page.has_no_text? "2 min"

    assert page.has_no_text? "No recipes found"
  end

  def test_search_by_ingredient
    visit "/"
    fill_in "Ingredient", with: "Bacon"
    click_on "Search"

    # Finds correct recipes
    assert page.has_text? "Carbonarra"
    assert page.has_text? "Sandwich"
    assert page.has_text? "Pizza"
    assert page.has_no_text? "Pierogi"

    # Display associated ingredients
    assert page.has_text? "Bacon"
    assert page.has_text? "Eggs"
    assert page.has_text? "Bread"
    assert page.has_no_text? "Potatoes"

    # Display instructions
    assert page.has_text? "Cook spaghetti in the pot."
    assert page.has_no_text? "Make stuffing from cheese, potatoes and onion."

    # Displays cooking time
    assert page.has_text? "2 min"

    assert page.has_no_text? "No recipes found"
  end

  def test_search_by_both_cuisine_and_ingredient
    visit "/"
    fill_in "Cuisine", with: "Italian"
    fill_in "Ingredient", with: "Flour"
    click_on "Search"

    # Finds correct recipes
    assert page.has_text? "Pizza"
    assert page.has_no_text? "Pierogi"
    assert page.has_no_text? "Carbonarra"
    assert page.has_no_text? "Sandwich"

    # Display associated ingredients
    assert page.has_text? "Flour"
    assert page.has_text? "Bacon"
    assert page.has_no_text? "Eggs"

    # Display instructions
    assert page.has_text? "Make dough, add things, put into oven."
    assert page.has_no_text? "Make stuffing from cheese, potatoes and onion."
    assert page.has_no_text? "Cook spaghetti in the pot."

    # Displays cooking time
    assert page.has_text? "120 min"
    assert page.has_no_text? "2 min"

    assert page.has_no_text? "No recipes found"
  end

  def test_search_may_return_no_results
    visit "/"
    fill_in "Cuisine", with: "American"
    fill_in "Ingredient", with: "Jalapeno"
    click_on "Search"

    assert page.has_text? "No recipes found"

    assert page.has_no_text? "Pizza"
    assert page.has_no_text? "Pierogi"
    assert page.has_no_text? "Carbonarra"
    assert page.has_no_text? "Sandwich"

    assert page.has_no_text? "Flour"
    assert page.has_no_text? "Bacon"
  end

  def test_find_all_when_no_criteria_given
    visit "/"
    click_on "Search"

    assert page.has_text? "Pizza"
    assert page.has_text? "Pierogi"
    assert page.has_text? "Carbonarra"
    assert page.has_text? "Sandwich"

    assert page.has_no_text? "No recipes found"
  end
end
