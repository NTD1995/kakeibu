# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

aa = User.find_or_create_by!(email: "aa@aa") do |user|
  user.name = "aa"
  user.password = "aaaaaa"
  user.introduction = "よろしくお願いします"
  user.is_active = true
end

bb = User.find_or_create_by!(email: "bb@bb") do |user|
  user.name = "bb"
  user.password = "bbbbbb"
  user.introduction = "よろしくお願いします"
  user.is_active = true
end

admin = Admin.find_or_create_by!(email: "admin@admin") do |admin|
  admin.password = "aaaaaa"
end

item_食費 = Item.find_or_create_by!(name: "食費")
item_給料 = Item.find_or_create_by!(name: "給料")

post = Post.find_or_create_by!(user_id: aa.id, item_id: item_給料.id) do |post|
  post.content = "月給"
  post.price = 1
  post.memo = ""
  post.category = "income"
  post.created_at = "2025-03-11 11:59:21.300603000 +0000"
end

