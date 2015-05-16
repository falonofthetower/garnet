class TrialsController < ApplicationController
  def index
    @trials = Trial.all
  end
end
