class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    session['636032966494875|fIXjzfgG26XJTyWkxQ7JRWF9uOY']
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
  def signup_facebook
    facebook_token = request.env['omniauth.auth']['credentials']['token']
    graph = Koala::Facebook::GraphAPI.new('636032966494875|fIXjzfgG26XJTyWkxQ7JRWF9uOY')
    for facebook_page in graph.get_object("me/accounts/page")
                      page_id = facebook_page["id"]
                      page_name = facebook_page["name"]
    end
  end

end