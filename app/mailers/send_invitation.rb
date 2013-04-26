class SendInvitation < ActionMailer::Base
  default from: "from@example.com"

  def send_invitation
    mail(:to => "alex_cd91@yahoo.com",
         :from => "example.com",
         :subject => "It's working!") do |format|
           format.html
         end
  end
end
