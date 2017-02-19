task init: :environment do 
  team = Team.create(title: 'team1')
  project = team.projects.create(title: 'project1')
  user = team.users.create!(name: 'user1')
  puts "all created"
end