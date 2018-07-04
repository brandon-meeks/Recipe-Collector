require_relative "../db/connection"

class Ingredient < ActiveRecord::Base
  belongs_to :recipe
  
end