class SearchsController < ApplicationController
  def search
    @content = params["content"]
    @model = params["model"]
    @method = params["method"]
    @records = search_for(@content, @model, @method)
  end

  private
  def search_for(content, model, method)
    if model == "user"
      if method == "perfect"
        User.where(name: content)
      elsif method == "partial"
        User.where("name LIKE ?", "%"+content+"%")
      elsif method == "prefix"
        User.where("name LIKE ?", content+"%")
      elsif method == "backword"
        User.where("name LIKE ?", "%"+content)
      end
    elsif model == "book"
      if method == "perfect"
        Book.where(title: content)
      elsif method == "partial"
        Book.where("title LIKE ?", "%"+content+"%")
      elsif method == "prefix"
        Book.where("title LIKE ?", content+"%")
      elsif method == "backword"
        Book.where("title LIKE ?", "%"+content)
      end
    end
  end
end
