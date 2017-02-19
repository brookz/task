require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "loads first 50 events of the events into @events" do
      user = create(:user)
      todo1 = nil
      project = create(:project, team_id: user.team.id) do |project|
        todo1 = project.todos.create(attributes_for(:todo).merge(operator_id: user.id))
      end
      event1 = todo1.events.last
      get :index

      expect(assigns(:events).first).to eq event1
    end
  end
end
