class UserGroupsController < ApplicationController
  before_action :check_group_owner, only: [:create]
  before_action :check_exist_user, only: [:create]
  before_action :check_user_already_present, only: [:create]

  def create 
    ActiveRecord::Base.transaction do
      user_group = UserGroup.create(user: @user, group_id: params[:group_id])
      UserGroupMailer.join_group(user_group).deliver_later
      redirect_to({controller: "groups", action: "edit", id: params[:group_id]}, notice: t('groups.add_user_group')) && return
    end
    redirect_to({controller: "groups", action: "edit", id: params[:group_id]}, error: t('global.error_occured'))
  end

  def destroy 
    UserGroup.find(params.has_key?(:user_group_id) ? params[:user_group_id] : params[:id]).destroy
    redirect_to({controller: "groups", action: "edit", id: params[:group_id]}, notice: t('groups.delete_user_group')) if !params.has_key?(:return_to)
    redirect_to({controller: params[:return_to].split('#')[0], action: params[:return_to].split('#')[1]}, notice: t('groups.delete_user_group')) if params.has_key?(:return_to)
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