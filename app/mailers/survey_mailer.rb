class SurveyMailer < ApplicationMailer

  def survey_created(survey, user_group)
    @survey = survey
    mail(
      to: user_group.user.email,
      subject: t('surveys.new_survey')
    )
  end

end