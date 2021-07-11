class GroupsController < ApplicationController
  before_action :check_group_owner, only: [:edit, :update]

  def index 
    @my_groups = current_user.groups
    @other_groups = current_user.user_groups
  end

  def create 
    group = Group.create(user: current_user, name: params[:name])
    redirect_to edit_group_url(id: group.id)
  end

  def edit 
  end

  def update
    group = Group.find(params[:id])
    group.update(name: params[:name])
    redirect_to({action: "edit", id: params[:id]}, notice: t('groups.update_ok')) && return
  end

end