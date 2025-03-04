# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(email: "aa@aa", password: "aaaaaa", name: "aa", introduction: "よろしくお願いします", is_active: "true")
Admin.create(email: "admin@admin",password: "aaaaaa")
Item.create([{ name: "食費" }, { name: "給料" }])