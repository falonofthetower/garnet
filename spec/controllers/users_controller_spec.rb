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
       post :create, user: Fabricate(:user)
     end
     it "saves the user in the database" do
       expect(User.count).to eq(1)
     end
     it "redirects to the index page"
   end

   context "with invalid attributes" do
     it "does not save the user in the database"
     it "re-renders the :new tamplate"
   end
  end
end
