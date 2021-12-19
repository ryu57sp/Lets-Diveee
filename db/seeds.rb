# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(
  name: "イルカ",
  email: "dolphin@ocean.com",
  password: "1111111",
  profile_image: File.open("#{Rails.root}/app/assets/images/NO_IMAGE.jpg"),
  profile: "ハシナガイルカです！",
  diver_rank: "オープンウォーター",
  is_deleted: false
  )

User.create!(
  name: "クジラ",
  email: "whale@ocean.com",
  password: "3333333",
  profile_image: File.open("#{Rails.root}/app/assets/images/NO_IMAGE.jpg"),
  profile: "ザトウクジラです！",
  diver_rank: "レスキュー",
  is_deleted: false
  )

User.create!(
  name: "ウミガメ",
  email: "honu@ocean.com",
  password: "5555555",
  profile_image: File.open("#{Rails.root}/app/assets/images/NO_IMAGE.jpg"),
  profile: "アオウミガメです！",
  diver_rank: "インストラクター以上",
  is_deleted: false
  )

User.create!(
  name: "シャチ",
  email: "orca@ocean.com",
  password: "7777777",
  profile_image: File.open("#{Rails.root}/app/assets/images/NO_IMAGE.jpg"),
  profile: "海の王者です！",
  diver_rank: "オープンウォーター",
  is_deleted: false
  )

User.create!(
  name: "サメ",
  email: "shark@ocean.com",
  password: "9999999",
  profile_image: File.open("#{Rails.root}/app/assets/images/NO_IMAGE.jpg"),
  profile: "ホホジロザメです！",
  diver_rank: "インストラクター以上",
  is_deleted: false
  )

Dive.create!(
  user_id: 1,
  image: File.open("#{Rails.root}/app/assets/images/post1.jpg"),
  title: "透明度抜群の海！",
  body: "ハワイで１番のスポットです！",
  dive_point: "エレクトリックビーチ",
  water_temperature: "２３〜２５℃",
  maximum_depth: "７〜１０m",
  season: "５月",
  dive_shop: "セルフダイビング"
  )

Dive.create!(
  user_id: 1,
  image: File.open("#{Rails.root}/app/assets/images/post2.jpg"),
  title: "ウミヘビのトルネード！",
  body: "ウミヘビに襲われました。笑",
  dive_point: "恩納村（沖縄）",
  water_temperature: "２０〜２３℃",
  maximum_depth: "１０〜１５m",
  season: "３月",
  dive_shop: "セルフダイビング"
  )

Dive.create!(
  user_id: 2,
  image: File.open("#{Rails.root}/app/assets/images/post3.jpg"),
  title: "ウミガメだらけのタートルロック！",
  body: "隠れ家的なスポットです！",
  dive_point: "マカハビーチ",
  water_temperature: "２３〜２５℃",
  maximum_depth: "２５〜３０m",
  season: "７月",
  dive_shop: "セルフダイビング"
  )

Dive.create!(
  user_id: 2,
  image: File.open("#{Rails.root}/app/assets/images/post4.jpg"),
  title: "御蔵島でドルフィンスイム！",
  body: "ハシナガイルカの大群と泳ぎました！",
  dive_point: "御蔵島",
  water_temperature: "２０〜２３℃",
  maximum_depth: "１０〜１５m",
  season: "１２月",
  dive_shop: "セルフダイビング"
  )

Dive.create!(
  user_id: 3,
  image: File.open("#{Rails.root}/app/assets/images/post5.jpg"),
  title: "ホヌと太陽光！",
  body: "神々しいウミガメ！",
  dive_point: "エレクトリックビーチ",
  water_temperature: "２３〜２５℃",
  maximum_depth: "７〜１０m",
  season: "７月",
  dive_shop: "セルフダイビング"
  )

Dive.create!(
  user_id: 3,
  image: File.open("#{Rails.root}/app/assets/images/post6.jpg"),
  title: "洞窟ダイビング！",
  body: "地形ダイブ最高でした！",
  dive_point: "慶良間諸島（沖縄）",
  water_temperature: "１８〜２０℃",
  maximum_depth: "３５m〜",
  season: "２月",
  dive_shop: "セルフダイビング"
  )
