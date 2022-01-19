require 'rails_helper'

RSpec.describe UsersController, type: :controller do
    describe "get #index" do
        it "renders the user index" do
            get :index
            expect(response.to render_template(:index))
        end
    end

    describe "get #new" do
        it "brings up the form to make a new user" do
            get :new
            expect(response.to render_template(:new))
        end
    end

    describe "post #create" do
        before(:each) do
            create(:user)
            allow(subject).to_receive(:current_user).and_return(User.last)
        end

        let(:valid_params) { {user: {username: 'Shawn', email: 'shawn@gmail.com'}}}
        let(:invalid_params) { {user: {username: 'Aagam'}}}
    end

end