class FamilyMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.family_mailer.confirmation_email.subject
  #
  def confirmation_email(family_id)
    @family = Family.find(family_id)

    mail to: @family.email,
         subject: "Confirmation: Your Family is Registered"
  end
end
