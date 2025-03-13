# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# ユーザーの作成
aa = User.find_or_create_by!(email: "aa@aa") do |user|
  user.name = "aa"
  user.password = "aaaaaa"
  user.introduction = "よろしくお願いします"
  user.is_active = true
end

# 他ユーザーの作成
bb = User.find_or_create_by!(email: "bb@bb") do |user|
  user.name = "bb"
  user.password = "bbbbbb"
  user.introduction = "よろしくお願いします"
  user.is_active = true
end

# 管理者の作成
admin = Admin.find_or_create_by!(email: "admin@admin") do |admin|
  admin.password = "aaaaaa"
end

#  収入、支出項目の定義
income_categories = ['給与', '一時所得', '事業所得', '副業', '年金', '配当所得', '不動産所得', 'その他', '未分類']
expense_categories = ['食費', '日用品', '趣味・娯楽', '冠婚葬祭', '交通費', '衣服・美容', '健康・医療', '自動車',
                      '教養・教育', '現金・カード', '水道・光熱費', '通信費', '住宅', '税・社会保障', '保険', 'その他', '未分類']
# 収入項目の作成
income_categories.each do |name|
  Item.find_or_create_by!(name: name, category: "income")
end      
# 支出項目の作成
expense_categories.each do |name|
  Item.find_or_create_by!(name: name, category: "expense")
end                       

# 投稿の作成
post = Post.find_or_create_by!(user_id: 1, item_id: 1) do |post|
  post.content = "月給"
  post.price = 1
  post.memo = ""
  post.category = "income"
  post.created_at = "2025-03-11 11:59:21"
end

# 他の投稿の作成
post2 = Post.find_or_create_by!(user_id: 2, item_id: 10) do |post|
  post.content = "食費"
  post.price = 1
  post.memo = ""
  post.category = "expense"
  post.created_at = "2025-03-11 11:59:21"
end