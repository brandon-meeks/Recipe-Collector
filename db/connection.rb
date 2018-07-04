require 'active_record'

ActiveRecord::Base.establish_connection(
  # If using sqlite for database
  database: 'development.db',
  adapter:  'sqlite3'
  # If using mysql for database
  # adapter:  'mysql2'
  # host:     'localhost',
  # username: 'db_user',
  # password: 'db_pass',
  # database: 'db_name'

  # If using Postgres for database
  # adapter:    'postgres',
  # host:       'localhost',
  # username:   'db_user',
  # password:   'db_pass',
  # database:   'db_name'
)
