class UserGroupsController < ApplicationController
  before_action :check_group_owner, only: [:create, :destroy]
  before_action :check_exist_user, only: [:create]
  before_action :check_user_already_present, only: [:create]

  def create 
    UserGroup.create(user: @user, group_id: params[:group_id])
    redirect_to({controller: "groups", action: "edit", id: params[:group_id]}, notice: t('groups.add_user_group'))
  end

  def destroy 
    UserGroup.find(params[:user_group_id]).destroy
    redirect_to({controller: "groups", action: "edit", id: params[:group_id]}, notice: t('groups.delete_user_group'))
  end

  private 

  def check_exist_user
    @user = User.find_by(email: params[:email])
    if(@user.nil?)
      redirect_to({controller: "groups", action: "edit", id: params[:group_id]}, error: t('groups.add_user_group_no_user')) and return
    end
  end

  def check_user_already_present 
    if(Group.find(params[:group_id]).check_user_already_present(@user))
      redirect_to({controller: "groups", action: "edit", id: params[:group_id]}, error: t('groups.add_user_group_already_add')) and return
    elsif(current_user == @user)
      redirect_to({controller: "groups", action: "edit", id: params[:group_id]}, error: t('groups.add_user_group_owner')) and return
    end
  end

end