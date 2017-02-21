require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  describe "GET #index" do
    before (:each) do
      @user = create(:user)
      sign_in @user
    end
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
      
      project = create(:project, team_id: @user.team.id)
      todo = project.todos.create(title: 'test', operator_id: @user.id)
      event = todo.events.last
      get :index

      expect(assigns(:events).first).to eq event
    end
  end
end
