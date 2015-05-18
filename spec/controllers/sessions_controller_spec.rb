require 'spec_helper'

describe SessionsController do
  describe "POST create" do
      let(:da_user) { Fabricate(:user) }
    context "with valid credentials" do
      before do
        post :create, email: da_user.email, password: da_user.password
      end

      it "puts the signed in user in the session" do
        expect(session[:user_id]).to eq(da_user.id)
      end

      it "redirects to the home_path" do
        expect(response).to redirect_to home_path
      end

      it "sets the flash message succes" do
        expect(flash[:success]).not_to be_blank
      end
    end

    context "with invalid credentials" do
      before do
        post :create, email: da_user.email, password: "#{da_user.password}plussomemore"
      end

      it "redirects to the sign in path" do
        expect(response).to redirect_to sign_in_path
      end

      it "does not put the signed in user in the session" do
        expect(session[:user_id]).to eq(nil)
      end

      it "sets the flash message error" do
        expect(flash[:danger]).not_to be_blank
      end
    end
  end

  describe "GET destroy" do
    let(:da_user) { Fabricate(:user) }
    before do
      post :create, email: da_user.email, password: da_user.password
      get :destroy
    end

    it "redirect_to sign_in_path" do
      expect(response).to redirect_to sign_in_path
    end

    it "clears the user from the session" do
      expect(session[:user_id]).to be_nil
    end

    it "sets the flash message" do
      expect(flash[:danger]).not_to be_blank
    end
  end
end
