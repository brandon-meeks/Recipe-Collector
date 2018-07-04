require_relative '../models/models'

User.destroy_all

User.create(username: 'Admin', email: 'admin@example.com', password: 'admin123')