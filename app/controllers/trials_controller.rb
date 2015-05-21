class TrialsController < ApplicationController
  before_action :require_user

  def index
    @trials = Trial.all_by_expiration current_user
  end

  def new
    @trial = Trial.new
  end

  def create
    @trial = Trial.new(trial_params)
    @trial.user_id = current_user.id
    if @trial.save
      redirect_to trials_path
    else
      flash.now[:danger] = "Something went wrong"
      render :new
    end
  end

  private

  def trial_params
    params.require(:trial).permit(:name, :url, :cancel_url, :instructions, :expiration_date, :user_id)
  end
end
