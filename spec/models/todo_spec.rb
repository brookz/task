require 'rails_helper'

RSpec.describe Todo, type: :model do
  it "insert an event after created" do 
    user = create(:user)
    project = create(:project, team_id: user.team.id) do |project|
      project.users << user
    end

    expect do 
      todo1 = project.todos.create(attributes_for(:todo).merge(operator_id: user.id))
    end.to change{ Event.count}.by(1)

  end


  
end
