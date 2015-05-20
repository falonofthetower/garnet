class TrialsController < ApplicationController
  def index
    @trials = Trial.all_by_expiration
  end

  def new
    @trial = Trial.new
  end

  def create
    @trial = Trial.new(trial_params)
    if @trial.save
      redirect_to trials_path
    else
      flash[:danger] = "Something went wrong"
      render :new
    end
  end

  private

  def trial_params
    params.require(:trial).permit(:name, :url, :cancel_url, :instructions, :expiration_date)
  end
end
