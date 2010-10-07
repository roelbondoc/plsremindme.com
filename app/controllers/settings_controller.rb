class SettingsController < ApplicationController
  before_filter :login_required

  def index
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = "Email address has been updated and a confirmation email has been sent."
      redirect_to settings_path
    else
      render :index
    end
  end

  def validate
    @user = current_user
    @user.update_attributes(:email_valid => true) if @user.email_validation_token = params[:t]
    redirect_to settings_path
  end
end
