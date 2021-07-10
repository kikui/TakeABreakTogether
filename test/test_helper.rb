ENV['RAILS_ENV'] ||= 'test'
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def create_user(params= {})
    User.create!(
      email: params[:email] || 'test@gmail.com',
      pseudo: params[:pseudo] || "pseudo",
      password: params[:password] || "password"
    )
  end

  def create_group(params= {})
    Group.create!(
      name: params[:name] || "name",
      user: params[:user] || create_user({email: 'group@gmail.com'}),

    )
  end

  def create_user_group(params= {})
    UserGroup.create!(
      user: params[:user] || create_user({email: 'user_group@gmail.com'}),
      group: params[:group] || create_group
    )
  end

  def create_survey(params= {})
    Survey.create!(
      date: params[:date] || DateTime.now,
      day_type: params[:day_type] || "noon",
      group: params[:group] || create_group,
      user: params[:user] || create_user({email: 'survey@gmail.com'})
    )
  end

  def create_proposal(params= {})
    Proposal.create!(
      name: params[:name] || "name",
      address: params[:address] || "address",
      survey: params[:survey] || create_survey
    )
  end

  def create_vote(params= {})
    Vote.create!(
      user: params[:user] || create_user({email: 'vote@gmail.com'}),
      proposal: params[:proposal] || create_proposal
    )
  end

end
