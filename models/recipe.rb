# require_relative '../db/connection'
require_relative '../config/imageUploader'

class Recipe < ActiveRecord::Base
  belongs_to :user
  has_many :ingredients

  validates_presence_of :title, :procedure

  mount_uploader :image, ImageUploader
end
