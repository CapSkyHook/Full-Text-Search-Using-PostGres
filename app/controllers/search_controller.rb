class SearchController < ApplicationController
  def search
    if params[:query].nil?
      @articles = []
    else
	  @articles = Article.text_search(params[:query])
	  # render json: @articles
	end
  end
end
