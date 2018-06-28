require_relative 'connection'

ActiveRecord::Schema.define do
  create_table :users, force: :cascade do |t|
    t.string    :username
    t.string    :email
    t.text    :password_digest
    t.string    :profile_photo, :default => ""
    t.datetime  :created_at
  end

  add_index :users, :username

  create_table :recipes, force: :cascade do |t|
    t.integer   :user_id, null: false
    t.string    :title
    t.string    :author
    t.integer   :ingredient_id
    t.text      :procedure
    t.string    :image
    t.datetime  :created_at
  end

  add_index :recipes, :user_id

  create_table :ingredients, force: :cascade do |t|
    t.integer   :recipe_id, null: false
    t.string    :name
    t.float     :quantity
    t.string    :type
  end

  add_index :ingredients, :recipe_id


end
