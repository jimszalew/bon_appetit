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

  def test_it_can_convert_recipe_to_readable_format
    pantry = Pantry.new
    recipe = Recipe.new('Oatmeal Raisin Cookies')
    recipe.add_ingredient('Oatmeal', 250)
    recipe.add_ingredient('Raisins', 15)
    recipe.add_ingredient('Brown Sugar', 0.005)
# binding.pry
    expected = {"Oatmeal"     => {quantity: 250, units: ""},
                "Raisins"     => {quantity: 15, units: ""},
                "Brown Sugar" => {quantity: 0.005, units: ""}}
    actual = pantry.format_recipe(recipe)

    assert_equal expected, actual
  end


  # def test_it_can_convert_units
  #   pantry = Pantry.new
  #   recipe = Recipe.new('Oatmeal Raisin Cookies')
  #   recipe.add_ingredient('Oatmeal', 500)
  #   recipe.add_ingredient('Raisins', 15)
  #   recipe.add_ingredient('Brown Sugar', 0.005)
  #   actual = pantry.convert_units(recipe)
  #
  #   assert_instance_of Hash, actual
  #   # assert_equal 5,
  #   # assert_equal 15,
  #   # assert_equal 5,
  #
  # end
end
