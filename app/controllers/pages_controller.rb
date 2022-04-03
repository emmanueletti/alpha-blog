class PagesController < ApplicationController
  def home
    respond_to do |format|
      if logged_in?
        format.html { redirect_to articles_path }
      else
        format.html { render 'home' }
      end
    end
  end
end
