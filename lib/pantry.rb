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

  def format_recipe(recipe)
    ingredients = recipe.ingredients
    ingredients.each_pair do |name, amount|
      formatted.store(name, ({quantity: amount, units: ""}))
    end
    formatted
  end

  # def convert_units(formatted)
  #   items = formatted.values
  #   items.map do |data|
  #     if data[:quantity] >= 100
  #       data[:quantity] = data[:quantity] / 100 && data[:units] = "Centi-Units"
  #     elsif data[:quantity] < 1
  #       data[:quantity] = data[:quantity] * 100 && data[:units] = "Milli-Units"
  #     else
  #       data[:quantity] =
  #     end
  #   end
  # end
end
