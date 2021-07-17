class UserGroupMailer < ApplicationMailer

  def join_group(user_group)
    @user_group = user_group
    mail(
      to: user_group.user.email,
      subject: t('groups.join_group_mailer')
    )
  end
  
end