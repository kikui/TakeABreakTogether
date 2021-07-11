class UsersController < ApplicationController

  skip_before_action :check_authenticate, :only => [:create, :new]
  before_action :check_user_owner, only: [:show, :update]

  def show 
    @user = current_user
  end 

  def create 
    if(check_confirm_password)
      redirect_to signup_url, error: "Confirm password error" and return
    end
    if(check_existing_user)
      redirect_to login_url, error: "user already exist" and return
    end
    user = User.create(params_create_user)
    session[:user_id] = user.id
    redirect_to surveys_url
  end

  def update 
    user = User.find(session[:user_id])
    if(check_change_password)
      update_user(user)
      redirect_to({action: "show", id: session[:user_id]}, notice: t('profil.updated_ok')) && return
    else 
      update_user_without_password(user)
      redirect_to({action: "show", id: session[:user_id]}, notice: t('profil.updated_ok'))
    end
  end

  private 

  def update_user_without_password(user)
    user.update(email: params[:email], pseudo: params[:pseudo])
  end

  def update_user(user)
    if(user.authenticate(params[:password]))
      redirect_to({action: "show", id: session[:user_id]}, error: t('profil.updated_current_password_ko')) && return
    end
    if(params[:password] != params[:confirm_password])
      redirect_to({action: "show", id: session[:user_id]}, error: t('profil.updated_password_ko')) && return
    end
    user.update(email: params[:email], pseudo: params[:pseudo], password: params[:password])
  end

  def check_change_password 
    !params[:current_password].empty?
  end

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