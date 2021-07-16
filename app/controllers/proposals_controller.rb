class ProposalsController < ApplicationController 
  before_action :check_survey_member, only: [:create, :update]
   
  def create 
    Proposal.create(name: params[:name], address: params[:address], survey_id: params[:id])
    redirect_to({controller: "surveys", action: "show", id: params[:id]}, notice: t('surveys.add_proposal'))
  end

  def update 
    Proposal.find(params[:proposal_id]).update(name: params[:name], address: params[:address])
    redirect_to({controller: "surveys", action: "show", id: params[:id]}, notice: t('surveys.update_proposal'))
  end
  
end