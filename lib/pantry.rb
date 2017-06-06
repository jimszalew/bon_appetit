class Pantry

  attr_reader :stock

  def initialize
    @stock = {}
  end

  def stock_check(ingredient)
    return 0 if !stock.keys.include?(ingredient)
    stock[ingredient]
  end

  def restock(ingredient, amount)
    stock.store(ingredient, amount)
  end
end
