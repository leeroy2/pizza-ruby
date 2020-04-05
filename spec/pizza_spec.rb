require 'rspec/autorun'
require_relative '../lib/pizza'

describe Margarita do
  context 'When testing the Margarita class' do
    let(:margarita) { Margarita.new }
    it 'should contain Cheese and tomato sauce' do
      output = margarita.return_pizza
      expect(output).to eq "Pizza Margarita\n----------------------\n- Cheese\n- Tomato sauce\n\n"
    end

    it 'should add peperoni' do
      margarita.add_peperoni
      output = margarita.return_pizza
      expect(output).to eq "Pizza Margarita\n----------------------\n- Cheese\n- Tomato sauce\n- Peperoni\n\n"
    end

    it 'should add bacon' do
      margarita.add_bacon
      output = margarita.return_pizza
      expect(output).to eq "Pizza Margarita\n----------------------\n- Cheese\n- Tomato sauce\n- Bacon\n\n"
    end

    it 'should add custom toppings' do
      margarita.add_toppings(%w[Proscutto Anchovies])
      output = margarita.return_pizza
      expect(output).to eq "Pizza Margarita\n----------------------\n- Cheese\n- Tomato sauce\n- Proscutto\n- Anchovies\n\n"
    end
  end
end

describe HamAndMushrooms do
  context 'When testing the HamAndMushrooms class' do
    let(:hamandmashrooms) { HamAndMushrooms.new }
    it 'should contain Cheese and tomato sauce Ham and Mushrooms' do
      output = hamandmashrooms.return_pizza
      expect(output).to eq "Pizza HamAndMushrooms\n----------------------\n- Cheese\n- Tomato sauce\n- Ham\n- Mushrooms\n\n"
    end
  end
end

describe FourCheese do
  context 'When testing the FourCheese class' do
    let(:fourcheese) { FourCheese.new }
    it 'should contain Cheese and tomato sauce Ham and Mushrooms' do
      output = fourcheese.return_pizza
      expect(output).to eq "Pizza FourCheese\n----------------------\n- Cheese\n- Blue cheese\n- Philadelfia\n- Mozzarela\n\n"
    end
  end
end

describe PizzaFactory do
  context 'Testing the PizzaFactory class' do
    let(:pizzafactory) { PizzaFactory.create_pizza('Margarita', ['Tofu'])}
    it 'should contain Cheese and tomato sauce and Tofu' do
      output = pizzafactory.return_pizza
      expect(output). to eq "Pizza Margarita\n----------------------\n- Cheese\n- Tomato sauce\n- Tofu\n\n"
    end
  end
end