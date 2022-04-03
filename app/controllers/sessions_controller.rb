class SessionsController < ApplicationController
  def new; end

  # research flash.now vs flash[:notice]
  # flash[:notice] vs flash.now
  # https://stackoverflow.com/questions/7133392/rails-flash-now-not-working
  # flash[:notice] will persist for one http cycle and will show up after a
  # http cycle - used after redirects
  # flash.now shows up immediately and does not wait for one http cycle to
  # show up on the next html page after a cycle
  def create
    email = params[:session][:email].downcase
    password = params[:session][:password]
    user = User.find_by(email: email)
    is_user_valid = user && user.authenticate(password)
    # FINALLY GOT RAILS 7 TURBO TO WORK
    # https://github.com/hotwired/turbo-rails/issues/12
    respond_to do |format|
      if is_user_valid
        # user is vaid
        # RAILS provides a session object that we can use to maintain user session state
        # https://guides.rubyonrails.org/action_controller_overview.html#session
        session[:user_id] = user.id
        flash[:notice] = 'Logged in successfully'
        redirect_to user
      else
        flash.now[:alert] = 'There was something wrong with your login details'
        format.html { render :new, status: :unprocessable_entity }
        # render 'new'
      end
    end
  end

  def destroy
    # logout
    session[:user_id] = nil
    flash[:notice] = 'Logged out'
    # If you are using XHR requests other than GET or POST and redirecting after
    # the request then some browsers will follow the redirect using the original
    # request method. This may lead to undesirable behavior such as a double DELETE.
    # To work around this you can return a 303 See Other status code which will
    # be followed using a GET request.
    # https://api.rubyonrails.org/classes/ActionController/Redirecting.html#method-i-redirect_to
    redirect_to root_path, status: 303
  end
end
