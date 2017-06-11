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
    check = pantry.stock_check('Oatmeal')

    assert_equal 0, check
  end

  def test_it_can_add_items_and_check_in_stock_items
    pantry = Pantry.new
    pantry.restock('Raisins', 100)
    check = pantry.stock_check('Raisins')

    assert_equal 100, check
  end

  def test_it_can_add_more_of_an_item
    pantry = Pantry.new
    pantry.restock('Raisins', 20)
    check_1 = pantry.stock_check('Raisins')

    assert_equal 20, check_1

    pantry.restock('Raisins', 100)
    check_2 = pantry.stock_check('Raisins')

    assert_equal 100, check_2
  end

  def test_it_can_build_a_recipe
    pantry = Pantry.new
    recipe = Recipe.new('Oatmeal Raisin Cookies')
    recipe.add_ingredient('Oatmeal', 25)
    recipe.add_ingredient('Raisins', 15)
    recipe.add_ingredient('Brown Sugar', 5)

    assert_instance_of Recipe, recipe
    assert_equal 25, recipe.ingredients['Oatmeal']
    assert_equal 15, recipe.ingredients['Raisins']
    assert_equal 5, recipe.ingredients['Brown Sugar']
  end

  def test_it_can_convert_units
    pantry = Pantry.new
    recipe = Recipe.new('Oatmeal Raisin Cookies')
    recipe.add_ingredient('Oatmeal', 500)
    recipe.add_ingredient('Raisins', 15)
    recipe.add_ingredient('Brown Sugar', 0.005)
    actual = pantry.convert_units(recipe)

    assert_instance_of Hash, actual
    assert_equal 5, actual['Oatmeal'][:quantity]
    assert_equal 15, actual['Raisins'][:quantity]
    assert_equal 5, actual['Brown Sugar'][:quantity]
    assert_equal 'Centi-Units', actual['Oatmeal'][:units]
    assert_equal 'Universal Units', actual['Raisins'][:units]
    assert_equal 'Milli-Units', actual['Brown Sugar'][:units]
  end

  def test_it_can_make_a_shopping_list_from_a_recipe
    pantry = Pantry.new
    recipe = Recipe.new('Oatmeal Raisin Cookies')
    recipe.add_ingredient('Oatmeal', 500)
    recipe.add_ingredient('Raisins', 15)
    recipe.add_ingredient('Brown Sugar', 0.005)
    pantry.add_to_shopping_list(recipe)
    actual = pantry.shopping_list
    expected ={"Oatmeal"=>500, "Raisins"=>15, "Brown Sugar"=>0.005}

    assert_instance_of Hash, actual
    assert_equal expected, actual
  end

  def test_it_can_make_a_shopping_list_from_more_than_one_recipe
    pantry = Pantry.new
    recipe_1 = Recipe.new('Oatmeal Raisin Cookies')
    recipe_1.add_ingredient('Oatmeal', 500)
    recipe_1.add_ingredient('Raisins', 15)
    recipe_1.add_ingredient('Brown Sugar', 0.005)
    pantry.add_to_shopping_list(recipe_1)
    recipe_2 = Recipe.new('Curry Chicken Salad')
    recipe_2.add_ingredient('Chicken', 500)
    recipe_2.add_ingredient('Raisins', 15)
    recipe_2.add_ingredient('Curry Powder', 0.025)
    pantry.add_to_shopping_list(recipe_2)
    actual = pantry.shopping_list
    expected ={"Oatmeal"=>500, "Raisins"=>30, "Brown Sugar"=>0.005, "Chicken"=>500, "Curry Powder"=>0.025}

    assert_equal expected, actual
  end
end
