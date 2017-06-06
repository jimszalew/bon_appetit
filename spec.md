## Pantry

### Preparation

Before coming to the assessment, students should clone down the starter repository [here](https://github.com/turingschool-examples/bon_appetit).

`git@github.com:turingschool-examples/bon_appetit.git`

It contains a standard directory scaffold as well as a straightforward recipe class.

### Iteration 1: Pantry Stocking

Build a simple Pantry-tracking program that can store a list of ingredients and available
quantities. Once we have tracked our ingredients and quantities, we'll use the Recipe class
we built before to have the pantry prepare a shopping list for us.

Support the following interactions:

```ruby
pantry = Pantry.new
# => <Pantry...>

# Checking and adding stock
pantry.stock
# => {}

pantry.stock_check("Cheese")
# => 0

pantry.restock("Cheese", 10)
pantry.stock_check("Cheese")
# => 10

pantry.restock("Cheese", 20)
pantry.stock_check("Cheese")
# => 30
```
### Iteration 2: Unit Conversions

So far our Pantry and Recipes have used a 1-tier unit scale -- the tried-and-true UNIVERSAL UNIT. But this becomes somewhat cumbersome for a busy chef in their kitchen. No one wants to try to measure out .0001 Universal Units.

Let's add a feature to our Pantry tracker that lets us output recipes with more readable unit conversions thrown in.

We'll introduce these units:

* Centi-Units -- Equals 100 Universal Units
* Milli-Units -- Equals 1/1000 Universal Units

Then, we'll add a new method, `convert_units`, which takes a `Recipe` and outputs updated units for it following these rules:

1. If the recipe calls for more than 100 Units of an ingredient, convert it to Centi-units
2. If the recipe calls for less than 1 Units of an ingredient, convert it to Milli-units

Follow this interaction pattern:

```ruby
# Building our recipe
r = Recipe.new("Spicy Cheese Pizza")
r.add_ingredient("Cayenne Pepper", 0.025)
r.add_ingredient("Cheese", 75)
r.add_ingredient("Flour", 500)

pantry = Pantry.new

# Convert units for this recipe

pantry.convert_units(r)

=> {"Cayenne Pepper" => {quantity: 25, units: "Milli-Units"},
    "Cheese"         => {quantity: 75, units: "Universal Units"},
    "Flour"          => {quantity: 5, units: "Centi-Units"}}
```

### Iteration 3: Shopping List

Add a feature to your pantry to generate a shopping list for a collection of recipes.

We'll follow this interaction pattern:

```ruby
pantry = Pantry.new
# => <Pantry...>

# Building our recipe
r = Recipe.new("Cheese Pizza")
# => <Recipe...>

r.ingredients
# => {}

r.add_ingredient("Cheese", 20)
r.add_ingredient("Flour", 20)

r.ingredients
# => {"Cheese" => 20, "Flour" => 20}

# Adding the recipe to the shopping list
pantry.add_to_shopping_list(r)

# Checking the shopping list
pantry.shopping_list # => {"Cheese" => 20, "Flour" => 20}

# Adding another recipe
r = Recipe.new("Spaghetti")
r.add_ingredient("Noodles", 10)
r.add_ingredient("Sauce", 10)
r.add_ingredient("Cheese", 5)
pantry.add_to_shopping_list(r)

# Checking the shopping list
pantry.shopping_list # => {"Cheese" => 25, "Flour" => 20, "Noodles" => 10, "Sauce" => 10}

# Printing the shopping list
pantry.print_shopping_list
# * Cheese: 25
# * Flour: 20
# * Noodles: 10
# * Sauce: 10
# => "* Cheese: 20\n* Flour: 20\n* Spaghetti Noodles: 10\n* Marinara Sauce: 10"
```


#### Iteration 4

This works well as long as all of our units are evenly divisible, but lets see if we can handle mixed units.

```ruby
# Building our recipe
r = Recipe.new("Spicy Cheese Pizza")
r.add_ingredient("Cayenne Pepper", 1.025)
r.add_ingredient("Cheese", 75)
r.add_ingredient("Flour", 550)

pantry = Pantry.new

# Convert units for this recipe

pantry.convert_units(r)

=> {"Cayenne Pepper" => [{quantity: 25, units: "Milli-Units"},
                         {quantity: 1, units: "Universal Units"}],
    "Cheese"         => [{quantity: 75, units: "Universal Units"}],
    "Flour"          => [{quantity: 5, units: "Centi-Units"},
                         {quantity: 50, units: "Universal Units"}]}
```
