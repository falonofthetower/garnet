require 'spec_helper'

describe UsersController do
  describe "GET new" do
    it "sets @user" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

  describe "POST create" do
   context "with valid attributes" do
     before do
       post :create, user: Fabricate.attributes_for(:user)
     end

     it "saves the user in the database" do
       expect(User.count).to eq(1)
     end

     it "redirects to the index page" do
       expect(response).to redirect_to(trials_path)
     end
   end

   context "with invalid attributes" do
     before do
       post :create, user: { email: "neo@example.com" }
     end

     it "does not save the user in the database" do
       expect(User.count).to eq(0)
     end

     it "re-renders the :new tamplate" do
       expect(response).to render_template(:new)
     end
   end
  end
end
