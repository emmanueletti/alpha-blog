# All controllers created by us inherits from the applicationController found
# in the application_controller.rb file

class ArticlesController < ApplicationController
  def show
    # the @ in front converts the articles variable from a regular variable
    # inside this show method to an instance variable inside the ArticlesController
    # class. This instance variable will be be exposed to RAILS when the ArticlesController
    # gets instantiated bY RAILS, and can then be passed to other places in the
    # app (by RAILS) such as the show.html.erb view file

    # Also the last line in a ruby function / method is implicitly  returned.
    # My guess is that RAILS is instantiating this class, calling the show method
    # expecting an instance of the class with methods/getters/setters for managing
    # the database as the return value, then passing that return value to where
    # its needed
    @article = Article.find(params[:id])
  end
end
