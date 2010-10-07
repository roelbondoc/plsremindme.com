class RemindersController < ApplicationController
  before_filter :login_required

  def index
    @reminders = current_user.reminders.not_completed
  end

  def update
    @reminder = current_user.reminders.find(params[:id])
    if @reminder.update_attributes(params[:reminder])
      redirect_to reminders_path
    else
      render :index
    end
  end
end
