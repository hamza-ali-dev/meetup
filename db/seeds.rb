UsersGroup.destroy_all
User.destroy_all
Group.destroy_all

users = [
  { first_name: 'Test', last_name: 'User' },
  { first_name: 'Test', last_name: 'User 2' },
]

User.upsert_all(users)

puts 'Users created successfully'

groups = [
  { name: 'Tech Enthusiasts' },
  { name: 'Book Club' },
]

Group.upsert_all(groups)

puts 'Groups created successfully'

users_groups = [
  { user_id: User.first.id, group_id: Group.first.id, role: 'organizer' },
  { user_id: User.second.id, group_id: Group.first.id, role: 'presenter' },
  { user_id: User.second.id, group_id: Group.second.id, role: 'participant' },
]

UsersGroup.upsert_all(users_groups)

puts 'Users Groups created successfully'
