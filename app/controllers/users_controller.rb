class UsersController < ApplicationController
  before_action :set_user, only: [:show, :ensure_correct_user]
  before_action :ensure_correct_user,{only: [:show]}

    def new
      @user = User.new
    end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "ようこそ！タスク管理アプリへ！!"
      redirect_to tasks_path
    else
      render 'new'
    end
  end

  def show
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def ensure_correct_user
      if current_user.id  !=  @user.id.to_i
        flash[:notice] = "権限がありません"
        redirect_to tasks_path
      end
  end

end
