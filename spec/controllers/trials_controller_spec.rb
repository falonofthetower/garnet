require 'spec_helper'

describe TrialsController do
  describe "GET index" do
    context "For authenticated user" do
      let(:user) { Fabricate(:user) }
      before do
        session[:user_id] = user.id
      end

      it "sets @trials" do
        trial = Fabricate(:trial, user_id: user.id)
        get :index
        expect(assigns(:trials)).to match_array([trial])
      end

      it "only pull trials for the user" do
        other_user = Fabricate(:user)
        trial = Fabricate(:trial, user_id: user.id)
        other_trial = Fabricate(:trial, user_id: other_user.id)
        get :index
        expect(assigns(:trials)).to match_array([trial])
      end
    end

    context "for unauthenticated user" do
      it "redirects to root_path" do
        get :index
        expect(response).to redirect_to(login_path)
      end
    end
  end

  describe "POST create" do
    let(:user) { Fabricate(:user) }
    before do
      session[:user_id] = user.id
    end

    context "with valid inputs" do
      before do
        post :create, trial: Fabricate.attributes_for(:trial)
      end
      it "creates the trial" do
        expect(Trial.count).to eq(1)
      end

      it "redirects to index" do
        expect(response).to redirect_to(trials_path)
      end

      it "creates trial associated with the user" do
        expect(Trial.first.user).to eq(user)
      end
    end

    context "with invalid inputs" do
      before do
        post :create, trial: Fabricate.attributes_for(:trial, expiration_date: nil)
      end

      it "does not create the trial" do
        expect(Trial.count).to eq(0)
      end

      it "renders the new page" do
        expect(response).to render_template :new
      end

      it "sets the session danger message" do
        expect(flash[:danger]).not_to be_blank
      end

      it "sets @trial" do
        expect(assigns(:trial)).to be_instance_of(Trial)
      end
    end
  end

  describe "GET new" do
    let(:user) { Fabricate(:user) }
    before do
      session[:user_id] = user.id
    end

    it "sets @trial" do
      get :new
      expect(assigns(:trial)).to be_instance_of(Trial)
    end
  end

  describe "GET edit" do
      let(:user) { Fabricate(:user) }
      let(:trial) { Fabricate(:trial, user_id: user.id) }

    context "for authenticated user" do
      before do
        session[:user_id] = user.id
      end

      it "renders the edit page for a trial belonging to user" do
        get :edit, id: trial.id
        expect(response).to render_template :edit
      end

      it "redirects to index for a trial not belonging to the user" do
        other_user = Fabricate(:user)
        other_trial = Fabricate(:trial, user_id: other_user.id)
        get :edit, id: other_trial.id
        expect(response).to redirect_to trials_path
      end
    end

    context "for unauthenticated user" do
      it "redirects to the login page" do
        trial
        session[:user_id] = nil
        get :edit, id: trial.id
        expect(response).to redirect_to login_path
      end
    end
  end

  describe "DELETE destroy" do
    context "for authenticated user" do
      let(:user) { Fabricate(:user) }
      let(:other_user) { Fabricate(:user) }
      let(:users_trial) { Fabricate(:trial, user_id: user.id) }
      before do
        session[:user_id] = user.id
      end

      it "destroys the users trial" do
        expect { delete :destroy, {:id => users_trial.to_param}}.to change(Trial, :count).by(0)
      end

      it "does not destroy another users item" do
        other_trial = Fabricate(:trial, user_id: other_user.id)
        expect { delete :destroy, {:id => other_trial.to_param}}.to change(Trial, :count).by(0)
      end

      it "redirects to the index" do
        delete :destroy, {:id => users_trial.to_param}
        expect(response).to redirect_to trials_path
      end
    end
  end
end
