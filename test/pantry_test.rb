require './lib/pantry'
require './lib/recipe'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class PantryTest < Minitest::Test

  def test_it_exists
    pantry = Pantry.new

    assert_instance_of Pantry, pantry
  end

  def test_it_is_empty_upon_creation
    pantry = Pantry.new
    stock = pantry.stock

    assert_instance_of Hash, stock
    assert stock.empty?
  end

  def test_it_returns_zero_if_ingredient_isnt_in_pantry
    pantry = Pantry.new
    check = pantry.stock_check('Cheese')

    assert_equal 0, check
  end

  def test_it_can_add_items_and_check_in_stock_items
    pantry = Pantry.new
    pantry.restock('Cheese', 10)
    check = pantry.stock_check('Cheese')

    assert_equal 10, check
  end

  def test_it_can_add_more_of_an_item
    pantry = Pantry.new
    pantry.restock('Cheese', 10)
    check_1 = pantry.stock_check('Cheese')

    assert_equal 10, check_1

    pantry.restock('Cheese', 20)
    check_2 = pantry.stock_check('Cheese')

    assert_equal 30, check_2
  end

  def test_it_can_build_a_recipe
    pantry = Pantry.new
    recipe = Recipe.new('Spicy Cheese Pizza')
    recipe.add_ingredient('Cayenne Pepper', 0.025)
    recipe.add_ingredient('Cheese', 75)
    recipe.add_ingredient('Flour', 500)

    assert_instance_of Recipe, recipe
    assert_equal 0.025, recipe.ingredients['Cayenne Pepper']
    assert_equal 75, recipe.ingredients['Cheese']
    assert_equal 500, recipe.ingredients['Flour']
  end

  def test_it_can_convert_units
    pantry = Pantry.new
    recipe = Recipe.new('Spicy Cheese Pizza')
    recipe.add_ingredient('Cayenne Pepper', 0.025)
    recipe.add_ingredient('Cheese', 75)
    recipe.add_ingredient('Flour', 500)
    actual = pantry.convert_units(recipe)

    assert_instance_of Hash, actual
    assert_equal 25, actual['Cayenne Pepper'][:quantity]
    assert_equal 75, actual['Cheese'][:quantity]
    assert_equal 5, actual['Flour'][:quantity]
    assert_equal 'Milli-Units', actual['Cayenne Pepper'][:units]
    assert_equal 'Universal Units', actual['Cheese'][:units]
    assert_equal 'Centi-Units', actual['Flour'][:units]
  end

  def test_it_can_make_a_shopping_list_from_a_recipe
    pantry = Pantry.new
    recipe = Recipe.new('Cheese Pizza')
    recipe.add_ingredient('Cheese', 20)
    recipe.add_ingredient('Flour', 20)
    pantry.add_to_shopping_list(recipe)
    actual = pantry.shopping_list
    expected ={"Cheese"=>20, "Flour"=>20}

    assert_instance_of Hash, actual
    assert_equal expected, actual
  end

  def test_it_can_make_a_shopping_list_from_more_than_one_recipe
    pantry = Pantry.new

    recipe_1 = Recipe.new('Cheese Pizza')
    recipe_1.add_ingredient('Cheese', 20)
    recipe_1.add_ingredient('Flour', 20)

    recipe_2 = Recipe.new('Spaghetti')
    recipe_2.add_ingredient('Noodles', 10)
    recipe_2.add_ingredient('Sauce', 10)
    recipe_2.add_ingredient('Cheese', 5)

    pantry.add_to_shopping_list(recipe_1)
    pantry.add_to_shopping_list(recipe_2)

    actual = pantry.shopping_list
    expected ={"Cheese"=>25, "Flour"=>20, "Noodles"=>10, "Sauce"=>10}

    assert_equal expected, actual
  end

  def test_it_can_add_recipes_to_cookbook
    pantry = Pantry.new

    r1 = Recipe.new("Cheese Pizza")
    r1.add_ingredient("Cheese", 20)
    r1.add_ingredient("Flour", 20)

    r2 = Recipe.new("Pickles")
    r2.add_ingredient("Brine", 10)
    r2.add_ingredient("Cucumbers", 30)

    r3 = Recipe.new("Peanuts")
    r3.add_ingredient("Raw nuts", 10)
    r3.add_ingredient("Salt", 10)

    pantry.add_to_cookbook(r1)
    pantry.add_to_cookbook(r2)
    pantry.add_to_cookbook(r3)

    actual = pantry.cookbook

    assert_instance_of Hash, actual
  end

  def test_it_knows_what_recipes_you_can_make_based_on_available_ingredients
    pantry = Pantry.new

    r1 = Recipe.new("Cheese Pizza")
    r1.add_ingredient("Cheese", 20)
    r1.add_ingredient("Flour", 20)

    r2 = Recipe.new("Pickles")
    r2.add_ingredient("Brine", 10)
    r2.add_ingredient("Cucumbers", 30)

    r3 = Recipe.new("Peanuts")
    r3.add_ingredient("Raw nuts", 10)
    r3.add_ingredient("Salt", 10)

    pantry.add_to_cookbook(r1)
    pantry.add_to_cookbook(r2)
    pantry.add_to_cookbook(r3)

    pantry.restock("Cheese", 10)
    pantry.restock("Flour", 20)
    pantry.restock("Brine", 40)
    pantry.restock("Cucumbers", 40)
    pantry.restock("Raw nuts", 20)
    pantry.restock("Salt", 20)

    actual = pantry.what_can_i_make
    expected = ["Pickles", "Peanuts"]
# binding.pry
    assert_equal expected, actual
  end
end
