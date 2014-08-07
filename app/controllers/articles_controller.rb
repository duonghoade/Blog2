class ArticlesController < ApplicationController
	#before_action :authenticate, except: [:index, :show]

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new

    Settings.locale.languages.each do |i|
      @article.article_l10ns.build(language_code: i.code.downcase, display_name: i.display_name)
    end
  end

  def edit
  end

  def create
    @article = current_user.articles.new
    if @article.save!
      article_l10ns = params['article']['article_l10ns_attributes']

      article_l10ns.count.times do |index|
        ar = @article.article_l10ns.new(title: article_l10ns["#{index}"]['title'],
                                        content: article_l10ns["#{index}"]['content'],
                                        language_code: article_l10ns["#{index}"]['language_code'])
        ar.save!
      end

      redirect_to @article
    else
      redirect_to root_path
    end
  end



  def update

  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: t('Article was successfully destroyed') }
      format.json { head :no_content }
    end
  end
end
