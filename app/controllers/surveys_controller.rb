class SurveysController < ApplicationController
  def index 
    @survey = Survey.all
  end
end