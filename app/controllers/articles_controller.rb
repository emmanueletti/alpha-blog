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

    # ALSO it seems that the implicit return of controller actions is a view
    @article = Article.find(params[:id])
  end

  def index
    @articles = Article.all
  end

  def new; end

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
    @article = Article.new(params.require(:articles).permit(:title, :description))

    # Also cool - RAILS behind the scenes sanitizes user input before saving into the db
    # to prevent SQL injection attacks
    @article.save

    # RAILS will auto-magically pull out the id from the now saved @article instance object
    # and pass that to the article_path which is a shorthand for the actual HTTP route
    # for the displaying of the particle article (/article/:id)
    # redirect_to article_path(@article)

    # EVEN MORE RAILS MAGIC - short cut for redirect_to article_path(@article) below
    redirect_to @article
  end
end
