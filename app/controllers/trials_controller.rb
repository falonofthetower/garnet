class TrialsController < ApplicationController
  def index
    @trials = Trial.all_by_expiration
  end
end
