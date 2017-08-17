require './HashMakers.rb'

h = Hash.new
h = {}

quiz_scores = {quiz1: 92, quiz2: 87}

national_champs = HashMakers.new
national_champs.champs_maker

p national_champs.keys
p national_champs.values

country_capitals = { 
  Denmark: "Copenhagen", 
  Sweden: "Stockholm", 
  Germany: "Berlin", 
  France: "Paris", 
  Spain: "Madrid"
}

sweden_capital = country_capitals[:Sweden]

country_capitals.include?("Italy")
country_capitals.include?("France")
country_capitals.include?(:France)
country_capitals.include?(:france)

authors = {
  "Little Women" => "Louisa May Alcott", 
  "Robinson Crusoe" => "Daniel Defoe"
}

authors.default = "unknown"

authors["To Kill a Mockingbird"]

bestsellers = {
  "Come Rain or Come Shine" => "unknown", 
  "Make Me" => "unknown", 
  "The Girl in the Spider's Web" => "unknown", 
  "Go Set a Watchman" => "unknown", 
  "All the Light We Cannot See" => "unknown"
}

my_hash = HashMakers.new
my_hash.author_set(bestsellers)
p my_hash

authors = {
  "Little Women" => "Louisa May Alcott", 
  "Robinson Crusoe" => "Daniel Defoe"
}

authors.value?("Louisa May Alcott") # => true

remodel = {
  floor: "tile", 
  cabinets: "oak", 
  countertop: "corian", 
  faucet: "stainless steel", 
  refrigerator: "LG"
}

remodel.include?("oak") # => false
remodel.include?(:cabinets) # => true

#include? checks keys, value? checks values