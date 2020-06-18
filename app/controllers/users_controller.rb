class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :screen_user, only: [:edit, :update]
  
  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def index
    @users = User.all
    # @user = User.find(params[:id])
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.all
    render 'follows'
  end
  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.all
    render 'follows'
  end

  private
    def user_params
       params.require(:user).permit(:name, :introduction, :profile_image)
    end

    def screen_user
      unless params[:id].to_i == current_user.id
        redirect_to user_path(current_user)
      end
    end

end

