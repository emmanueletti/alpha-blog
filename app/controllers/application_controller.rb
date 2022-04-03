class ApplicationController < ActionController::Base
  #  we can pass methods here to also be available to application helper by declaring:
  helper_method :current_user, :logged_in? # this allows current_user to be available to views as well

  # any helper methods here will be accessible to every child class
  # aka the other controllers that inherit from applicationConroller
  def current_user
    # we have access to the session object which
    # it seems that "||=" is the same as "??" in JS/dart
    # using this so we dont hit the database everytime - we can return the
    # current_user instance variable if it is not null
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    # in ruby to turn something into a bool use "!!"
    # https://stackoverflow.com/questions/3994033/ruby-operator-a-k-a-the-double-bang
    !!current_user
  end
end
