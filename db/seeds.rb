# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

img=File.open(File.join(Rails.root,'app/assets/images/default.png'))
(1..50).each do |i|
  User.create(name:"clone#{i}",email:"clone#{i}@gmail.com",image:img,password:"password")
end

