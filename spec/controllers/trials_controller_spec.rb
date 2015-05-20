require 'spec_helper'

describe TrialsController do
  describe "GET index" do
    let(:trial) { Fabricate(:trial) }

    it "sets @trials" do
     get :index
     expect(assigns(:trials)).to match_array([trial])
    end
  end

  describe "POST create" do
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
    it "sets @trial" do
      get :new
      expect(assigns(:trial)).to be_instance_of(Trial)
    end
  end
end
