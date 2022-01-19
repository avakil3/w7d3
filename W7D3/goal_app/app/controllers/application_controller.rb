class ApplicationController < ActionController::Base
	helper_method :current_user, :logged_in? # whatever methods we pass to helper_method, will be available in our views


    def login!(user)
        session[:session_token] = user.reset_session_token!
        # session is one of the cookies that rails provides! 
    end 

    def logout!
        current_user.reset_session_token! if logged_in?
        session[:session_token] = nil
        @current_user = nil
    end 

    def current_user 
        @current_user ||= User.find_by(session_token: session[:session_token])
    end 

    def logged_in?
        !!current_user
        ## !! takes a value and turns it into a boolean value
    end 

    def require_logged_in # aka ensure_logged_in
        redirect_to new_session_url unless logged_in?
    end 

    def require_logged_out 
        redirect_to users_url if logged_in?
    end 

end
