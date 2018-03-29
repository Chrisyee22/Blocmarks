require 'faker'

3.times do
  pw = Faker::Internet.password(6)
  User.create!(
    username: Faker::Internet.unique.user_name(6..12),
    email: Faker::Internet.unique.safe_email,
    password: pw,
    password_confirmation: pw,
    confirmed_at: Time.now.utc
  )
end

users = User.all

6.times do
  Topic.create!(
    user: users.sample,
    title: Faker::Science.unique.element
  )
end
topics = Topic.all

24.times do
  Bookmark.create!(
    topic: topics.sample,
    url: Faker::Internet.url,
    user: users.sample
  )
end

puts "#{User.count} users"
puts "#{Topic.count} topics"
puts "#{Bookmark.count} bookmarks"
