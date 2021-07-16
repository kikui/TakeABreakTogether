class VotesController < ApplicationController 
  before_action :check_vote_owner, only: [:create, :destroy]
  before_action :check_too_late_to_vote, only: [:create, :destroy]

  def create 
    Vote.create(user_id: params[:user_id], proposal_id: params[:proposal_id])
    redirect_to({controller: "surveys", action: "show", id: params[:survey_id]}, notice: t('surveys.add_vote'))
  end 

  def destroy 
    Vote.find(params[:id]).destroy!
    redirect_to({controller: "surveys", action: "show", id: params[:survey_id]}, notice: t('surveys.delete_vote'))
  end

end