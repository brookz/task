require 'rails_helper'

RSpec.describe Todo, type: :model do
  it "insert an event after created" do 
    user = create(:user)

    expect do 
      project = create(:project, team_id: user.team.id) do |project|
        todo1 = project.todos.create(attributes_for(:todo).merge(operator_id: user.id))
      end
    end.to change{ Event.count}.by(1)

  end
end
