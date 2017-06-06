require_relative 'recipe'

class Pantry

  attr_reader :stock,
              :converted

  def initialize
    @stock = {}
    @converted = {}
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

  def calculate(recipe)
    recipe.ingredients.values.map do |amount|
      if amount < 1
        amount =  amount * 1000
      elsif amount  > 100
        amount = amount / 100
      else
        amount
      end
    end
  end

  # def convert_units(recipe)
  #   recipe.ingredients.map do |ingredient|
  #     converted.store(ingredient[0], {quantity: ingredient[1], unit: 'unit'})
  #   end
  #   converted.map do |ingredient|
  #     if ingredient[1][:quantity] < 1
  #       ingredient[1][:quantity] = ingredient[1][:quantity] * 1000 && ingredient[1][:units] = "Milli-Units"
  #     elsif ingredient[1][:quantity] > 100
  #       ingredient[1][:quantity] = ingredient[1][:quantity] / 100 && ingredient[1][:units] = "Centi-Units"
  #     else
  #       ingredient[1][:quantity] = ingredient[1][:quantity] && ingredient[1][:units] = "Universal Units"
  #     end
  #   end
  # end
end
