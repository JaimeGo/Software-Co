class DeedMailer < ApplicationMailer

  def step_change_email(deed)
    p 'esto debería estar acaa'
    @real_estate = deed.real_estate
    @lawyer = deed.lawyer
    @deed=deed
    # @user = user
    mail(
      to: @real_estate.email,
      subject: "Tu escritura #{deed.identifier} expirará en #{deed.duration} días"
    )
    mail(
      to: @lawyer.email,
      subject: "Tu escritura #{deed.identifier} expirará en #{deed.duration} días"
    )
  end

  def new_deed(deed)
    # @user = user
    p 'aaaaaaaaaa'
    @real_estate = deed.real_estate
    @lawyer = deed.lawyer
    @deed = deed
    @url = 'http://software-cia.herokuapp.com' # Socket.gethostname
    # p @real_estate, @lawyer
    mail(to: @lawyer.email, subject: "#{@real_estate.full_name} te ha asignado una escritura")
  end
end
