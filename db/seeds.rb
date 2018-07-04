require_relative '../models/models'

User.destroy_all

User.create([
  {
    username: "Admin",
    email: "admin@example.com",
    password: "admin123"
  }
])

# Recipe.destroy_all
#
# Recipe.create([
#   {
#
#   }
# ])
