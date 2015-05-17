require 'spec_helper'

describe TrialsController do
  describe "GET index" do
    let(:trial) { Fabricate(:trial) }

    it "sets @trials" do
     get :index
     expect(assigns(:trials)).to match_array([trial])
    end
  end
end
