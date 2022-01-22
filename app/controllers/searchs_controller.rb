class SearchsController < ApplicationController
  def search
    @content = params["content"]
    @model = params["model"]
    @method = params["content"]
    @records = search_for(@content, @model, @method)
  end

  private
  def search_for(content, model, method)
    if model == "user"
      if method == "perfect"
        User.where(name: content)
      else
        User.where("name LIKE ?", "%"+content+"%")
      end
    elsif model == "book"
      if method == "perfect"
        Book.where(title: content)
      else
        Book.where("title LIKE ?", "%"+content+"%")
      end
    end
  end
end
