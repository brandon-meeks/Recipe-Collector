require_relative '../models/models'

User.destroy_all

User.create(username: 'Admin', email: 'admin@example.com', password: 'admin123', role: 'superuser')
puts "Admin user created"
User.create(username: 'User', email: 'user@examplte.com', password: 'user123', role: 'standard')
puts "User created"