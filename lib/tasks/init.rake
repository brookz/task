task init: :environment do 
  team = Team.create(title: 'team1')
  project = team.projects.create(title: 'project1')
  user = team.users.create!(name: 'user1', email: 'brook@test.com', password: '123456')
  puts "all created"
end

task event: :environment do 
  user = User.first
  # ActionCable.server.broadcast "receiver:#{user.id}", 
  #     { title: 'New things!', body: 'All the news that is fit to print' }
  ActionCable.server.broadcast "receiver:#{user.id}", 
      {
        id: 100, name: user.name, action: I18n.t('todo_create'), 
        title: 'test task', created_at: DateTime.now.to_s(:short)
      }
end