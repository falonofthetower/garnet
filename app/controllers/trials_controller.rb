class TrialsController < ApplicationController
  before_action :set_trial, only: [:edit, :update]
  before_action :require_user
  before_action :require_creator, only: [:edit, :update]

  helper_method :creator?

  def index
    @active_trials = Trial.all_active current_user
    @expired_trials = Trial.all_expired current_user
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

  def edit; end

  def update
    if @trial.update(trial_params)
      flash[:success] = "Trial updated"
      redirect_to trials_path
    else
      render :edit
    end
  end

  def destroy
    @trial = Trial.find(params[:id])
    if @trial.user != current_user
      flash[:danger] = "Something went wrong"
    else
      @trial.destroy if (@trial.user == current_user)
    end
    redirect_to trials_path
  end

  private

  def creator?
    current_user == @trial.user
  end

  def set_trial
    @trial = Trial.find(params[:id])
  end

  def trial_params
    params.require(:trial).permit(:name, :url, :cancel_url, :instructions, :expiration_date)
  end

  def require_creator
    return_to_index unless creator?
  end

  def return_to_index
    redirect_to trials_path
  end
end
