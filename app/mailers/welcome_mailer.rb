class WelcomeMailer < ApplicationMailer
  default from: ENV['USER_NAME']

  def welcome_email
    @user = params[:user]
    mail(to: @user.email, subject: '会員登録が完了しました。')
  end

end
