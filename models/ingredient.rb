require_relative '../db/connection'

# The Ingredient model
class Ingredient < ActiveRecord::Base
  belongs_to :recipe
end