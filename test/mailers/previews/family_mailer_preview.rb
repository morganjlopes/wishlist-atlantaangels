# Preview all emails at http://localhost:3000/rails/mailers/family_mailer
class FamilyMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/family_mailer/confirmation_email
  def confirmation_email
    FamilyMailer.confirmation_email
  end

end
