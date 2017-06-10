require_relative 'recipe'

class Pantry

  attr_reader :stock,
              :formatted,
              :calculated

  def initialize
    @stock = {}
    @formatted = {}
    @calculated = []
  end

  def stock_check(ingredient_name)
    return 0 if !stock.keys.include?(ingredient_name)
    stock[ingredient_name]
  end

  def restock(ingredient_name, amount)
    stock.store(ingredient_name, amount)
  end

  def add_recipe(recipe)
    recipe = Recipe.new(name)
  end

  def convert_units(recipe)
    items = recipe.ingredients
    items.map do |item, quantity|
      items[item] = if quantity < 1
                      milli_units(quantity)
                    elsif quantity >= 100
                      centi_units(quantity)
                    else
                      universal_units(quantity)
                    end
                  end
    items
  end

  def milli_units(quantity)
    {quantity: (quantity * 1000).round, units: 'Milli-Units'}
  end

  def centi_units(quantity)
    {quantity: (quantity / 100), units: 'Centi-Units'}
  end

  def universal_units(quantity)
    {quantity: quantity, units: 'Universal Units'}
  end
end
