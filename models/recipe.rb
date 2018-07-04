require "./db/connection"

class Recipe < ActiveRecord::Base
  belongs_to :user
  has_many :ingredients

  validates_presence_of :title, :procedure
end
