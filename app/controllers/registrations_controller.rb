class RegistrationsController < Devise::RegistrationsController

  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  private

  def sign_up_params
    params.require(:author).permit(:name, :email, :password, :password_confirmation, :avatar)
  end

  def account_update_params
    params.require(:author).permit(:name, :email, :password, :password_confirmation, :current_password, :avatar)
  end
end