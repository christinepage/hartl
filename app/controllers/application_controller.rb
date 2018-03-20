class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location  # save page (in the session) so we can go to it after they log in
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

end
