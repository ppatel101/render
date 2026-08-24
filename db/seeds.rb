# Seed initial sample users
sample_users = [
  { name: "Ada Lovelace", email: "ada.lovelace@example.com", age: 36 },
  { name: "Alan Turing", email: "alan.turing@example.com", age: 41 },
  { name: "Grace Hopper", email: "grace.hopper@example.com", age: 85 },
  { name: "Margaret Hamilton", email: "margaret.hamilton@example.com", age: 87 },
  { name: "Linus Torvalds", email: "linus.torvalds@example.com", age: 54 }
]

sample_users.each do |attributes|
  User.find_or_create_by!(email: attributes[:email]) do |user|
    user.name = attributes[:name]
    user.age = attributes[:age]
  end
end

puts "Seeded #{User.count} users successfully."
