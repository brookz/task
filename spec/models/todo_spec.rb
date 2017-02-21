require 'rails_helper'

RSpec.describe Todo, type: :model do
  before(:each) do 
    @user = create(:user)
    @project = create(:project, team_id: @user.team.id)
    @project.users << @user
  end

  it "insert an event after created" do 
    expect do 
      todo = @project.todos.create(attributes_for(:todo).merge(operator_id: @user.id))
    end.to change{ Event.count}.by(1)
  end

  it "insert an event after update" do 
    todo = @project.todos.create(attributes_for(:todo).merge(operator_id: @user.id))
    
    expect do 
      todo.update(recipient_id: @user.id)
    end.to change{ Event.count }.by(1)
  end

  it "insert destroy action into events" do
    todo = @project.todos.create(attributes_for(:todo).merge(operator_id: @user.id))
    expect do 
      todo.update(status: -1)
    end.to change{ Event.count }.by(1)
  end

  it "insert an event after commented" do 
    todo = @project.todos.create(attributes_for(:todo).merge(operator_id: @user.id))
    expect do 
      todo.comments.create(note: 'test', user_id: @user.id)
    end.to change{ Event.count }.by(1)
  end


  
end
