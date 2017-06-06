class Pantry

  attr_reader :stock

  def initialize
    @stock = {}
  end

  def stock_check(ingredient)
    return 0 if !stock.keys.include?(ingredient)
    
  end
end
