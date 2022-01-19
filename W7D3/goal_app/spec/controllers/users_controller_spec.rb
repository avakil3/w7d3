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

	context "with valid params" do
		it "creates the user" do
			post :create, params: valid_params
			expect(User.last.username).to eq("Shawn")
			expect(User.last.email).to eq("shawn@gmail.com")
		end

		it "redirects to user's page" do
			post :create, params: valid_params
			expect(response).to redirect_to (user_url(User.last.id))
		end
	end

	context "with invalid params" do
		before :each do
			post :create, params: invalid_params
		end

		it "renders new template" do
			expect(response).to render_template(:new)
		end

		it "adds errors to flash" do
			expect(flash[:errors]).to be_present
		end

	end


end