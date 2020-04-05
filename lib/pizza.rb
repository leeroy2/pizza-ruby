require 'thor'

# Module for output decoration
module Decorate
  def decorate
    item = ''
    item << "Pizza #{self.class.name}\n"
    item << "----------------------\n"
    @toppings.each do |topping|
      item << "- #{topping}\n"
    end
    item << "\n"
    item
  end
end

# Base class Pizza
class Pizza
  include Decorate
  attr_reader :print

  def self.descendants
    ObjectSpace.each_object(Class).select { |klass| klass < self }
  end

  def initialize
    @toppings = []
  end

  def add_peperoni
    @toppings << 'Peperoni'
  end

  def add_bacon
    @toppings << 'Bacon'
  end

  def add_toppings(list)
    list.each do |l|
      begin
        raise "#{l} is not String" unless l.is_a?(String)

        @toppings << l
      rescue StandardError => e
        puts e.message
      end
    end
  end

  def print
    puts decorate
  end

  def return_pizza
    decorate
  end
end

# Class Margarita inherited by Pizza
class Margarita < Pizza
  def initialize
    @toppings = ['Cheese', 'Tomato sauce']
  end
end

# Class HamAndMushrooms inherited by Pizza
class HamAndMushrooms < Pizza
  def initialize
    @toppings = ['Cheese', 'Tomato sauce', 'Ham', 'Mushrooms']
  end
end

# Class FourCheese inherited by Pizza
class FourCheese < Pizza
  def initialize
    @toppings = ['Cheese', 'Blue cheese', 'Philadelfia', 'Mozzarela']
  end
end

# Class for pizza creation
class PizzaFormatter
  def self.message
    msg = 'Unsupported pizza name'
    msg << "\nSupported pizza names"
    msg << format('%<pizza>s', pizza: Pizza.descendants)
    msg
  end

  def self.for(pizza_name)
    matcher = {}
    matcher['Margarita'] = Margarita.new
    matcher['HamAndMushrooms'] = HamAndMushrooms.new
    matcher['FourCheese'] = FourCheese.new

    return matcher[pizza_name] if matcher.include?(pizza_name)

    raise message
  end
end

# Factory class
class PizzaFactory
  def self.create_pizza(pizza_name, extra_toppings = [])
    begin
      raise "#{pizza_name} is not String" unless pizza_name.is_a?(String)
    rescue StandardError => e
      puts e.message
    end
    pizza = PizzaFormatter.for(pizza_name)
    pizza.add_toppings(extra_toppings)
    pizza
  end
end

# Implements command line utility using Thor
class CreatePizza < Thor
  desc 'create_pizza PIZZA_NAME EXTRA_TOPPINGS', 'creates pizzas and add some extra toppings'

  def create_pizza(name, *extra_toppings)
    toppings = []
    extra_toppings.each do |topping|
      toppings << topping
    end
    pizza = PizzaFactory.create_pizza(name, toppings)
    pizza.print
  end
end

CreatePizza.start(ARGV)
