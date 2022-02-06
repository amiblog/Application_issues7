class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    @q = Book.ransack(params[:q])
  end

  def index
    @users = User.all
    @book = Book.new
    @q = Book.ransack(params[:q])
    @books = @q.result
  end

  def followings
    user = User.find(params[:id])
    @users = user.followings
    @q = Book.ransack(params[:q])
    @books = @q.result
  end

  def followers
    user = User.find(params[:id])
    @users = user.followers
    @q = Book.ransack(params[:q])
    @books = @q.result
  end

  def edit
    @user = User.find(params[:id])
    @q = Book.ransack(params[:q])
    @books = @q.result
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
