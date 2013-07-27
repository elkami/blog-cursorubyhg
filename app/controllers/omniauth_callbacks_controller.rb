class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter
    @user = User.find_or_create_by_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "twitter") if is_navigational_format?
    else
      flash[:error] = "Something went wrong"
      redirect_to new_user_registration_url
    end
  end

end