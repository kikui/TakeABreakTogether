class UsersController < ApplicationController

  skip_before_action :check_authenticate, :only => [:create, :new]

  def create 
    check_confirm_password
    if(check_confirm_password)
      redirect_to signup_url, notice: "Confirm password error" and return
    end
    if(check_existing_user)
      redirect_to login_url, notice: "user already exist" and return
    end
    user = User.create(params_create_user)
    session[:user_id] = user.id
    render surveys_url
  end

  def update 
  end

  private 

  def check_existing_user 
    !User.find_by(email: params[:email]).nil?
  end

  def check_confirm_password 
    params[:password] != params[:confirm_password]
  end

  def params_create_user 
    {
      email: params[:email],
      pseudo: params[:pseudo],
      password: params[:password]
    }
  end

end