require_relative 'recipe'

class Pantry

  attr_reader :stock,
              :shopping_list,
              :cookbook

  def initialize
    @stock = {}
    @shopping_list = {}
    @cookbook = []
  end

  def stock_check(ingredient_name)
    return 0 if !stock.keys.include?(ingredient_name)
    stock[ingredient_name]
  end

  def restock(ingredient_name, amount)
    if stock.has_key?(ingredient_name)
      stock[ingredient_name] += amount
    else
      stock[ingredient_name] = amount
    end
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

  def add_to_shopping_list(recipe)
    items = recipe.ingredients
    items.map do |item, quantity|
      if shopping_list.has_key?(item)
        shopping_list[item] += quantity
      else
        shopping_list.store(item, quantity)
      end
    end
  end

  def print_shopping_list
    print_out = ""
    shopping_list.each_pair do |item, quantity|
      print_out += "* #{item}: #{quantity}\n"
    end
    puts print_out
    print_out
  end

  def add_to_cookbook(recipe)
    cookbook << recipe
  end

  def what_can_i_make

  end
end
