# All controllers created by us inherits from the applicationController found
# in the application_controller.rb file

class ArticlesController < ApplicationController
  # define method to run before other specified methods
  # if specified methods is empty, then will run before all methods
  before_action :find_article_by_param_id, only: %i[show edit update destroy]

  # guarding protected routes, the order matters
  # first users logged in status will be checked, the specific access will be checked
  before_action :require_user_logged_in, except: %i[show index] # defined in the parent ApplicationController
  before_action :require_access_to_article, only: %i[edit destroy update]

  def show
    # the @ in front converts the articles variable from a regular variable
    # inside this show method to an instance variable inside the ArticlesController
    # class which can be accessed by other methods, internal RAILS views builders, etc..
    # This instance variable will be be exposed to RAILS internal processes when the ArticlesController class
    # gets instantiated by RAILS, and can then be passed to other places in the
    # app (by RAILS) such as the show.html.erb view file which itself accesses "@articles" instance variable

    # Also the last line in a ruby function / method is implicitly  returned.
    # BUT guess is that RAILS is instantiating this class, calling the show method
    # which will assign create an "@article" instance variable in the class that all other methods
    # and views will have access to

    # params hash is passed to method from the route
    # can always pause execution with debugger and print out what the params hash looks like

    # commented out b/c we no longer need this line with the addition of the before_action
    # @article = Article.find(params[:id])
  end

  def index
    # @articles = Article.all
    # replaced the above with below for pagination - https://github.com/mislav/will_paginate
    @articles = Article.paginate(page: params[:page], per_page: 2)
  end

  def new
    # need to create an empty article instance variable to pass to the "new.html.erb"
    # view so it doesnt error out.
    # the only place that instance variable gets naturally created is in the
    # create method, where we check for errors if the instance variable created
    # fails to save
    @article = Article.new
  end

  def create
    # you can pass the entire articles hash found within the params hash and
    # RAILS will auto-magically destructure out the attributes for instantiating
    # the Articles object
    # so instead of Article.new(title: params[:articles][:title], description: params[:article][:title])
    # will use Article.new(params[:articles])
    # BUT will need to "whitelist" the user input - security feature introduce in
    # RAILS 4
    # so instead of Article.new(params[:articles])
    # will use the below code, which says
    # require the top level key of :article, then permit the :title and :description
    # values from that key to be used in instantiating the Article object
    @article = Article.new(article_params)

    @article.user = current_user

    # Also cool - RAILS behind the scenes sanitizes user input before saving into the db
    # to prevent SQL injection attacks
    if @article.save

      # flash is a special has that can be loaded key keys "notice" or "alert"
      # used for global view messaging in the main application.html.erb file
      flash[:notice] = 'Article was created successfully.'

      # RAILS will auto-magically pull out the id from the now saved @article instance object
      # and pass that to the article_path which is a shorthand for the actual HTTP route
      # for the displaying of the particle article (/article/:id)
      # redirect_to article_path(@article)

      # EVEN MORE RAILS MAGIC - short cut for redirect_to article_path(@article.id) below
      redirect_to @article
    else
      # render the new.html.erb template
      # apparently this pattern no longer works  in new rails:
      # turbo does not allow for rendered html as an immediate action of a form
      # submit - instead it wants a redirect
      # https://github.com/hotwired/turbo-rails/issues/12
      render 'new'
    end
  end

  # the edit form
  def edit
    # find the article we want to pass to the view for field population
    # we don't need to explicility repeat this find logic after consolidating it to
    # the re-useable find_article_by_param_id
    # @article = Article.find(params[:id])
  end

  # the endpoint to actually edit a database record
  def update
    # first find the article we want to edit
    # @article = Article.find(params[:id])

    # whitelist and use the fields we need
    result = @article.update(article_params)

    if result
      flash[:notice] = 'Article was edited successfully'
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    # @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end

  # anything below this "private" label will only be accessible inside this class
  private

  def article_params
    # not sure why category_ids is initialized to an empty array in the whitelisting
    # do know that we want to pass an an array to the create action (even if it is empty) since relationship is many to many
    params.require(:articles).permit(:title, :description, category_ids: [])
  end

  # creating a reuseable method to re-use logic
  def find_article_by_param_id
    @article = Article.find(params[:id])
  end

  def require_access_to_article
    # check if @article was created by the current user or the user is admin
    has_access = @article.user == current_user || current_user.admin?
    return if has_access

    # if not created by the current user redirect
    flash[:alert] = 'You can only edit or delete your article'
    redirect_to articles_path
  end
end
