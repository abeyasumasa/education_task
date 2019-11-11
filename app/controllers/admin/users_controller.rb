class Admin::UsersController < ApplicationController
  before_action :admin_user
  before_action :set_user, only:[:show, :edit, :update, :destroy]

      def index
        @users = User.all.includes(:tasks).order("created_at DESC")
      end

      def new
        @user = User.new
      end

      def create
        @user = User.new(user_params)
        if @user.save
          redirect_to admin_users_path
        else
          render 'new'
        end
      end

      def show
      end

      def edit
      end

      def update
        if @user.update(user_params)
          redirect_to admin_users_path, notice: "ユーザ情報を編集しました！"
        else
          render :edit
        end
      end

      def destroy
        if @user.destroy
          redirect_to admin_users_path, notice:"ユーザーを削除しました！"
        else
          redirect_to admin_users_path, notice:"管理ユーザーが存在しなくなるため、削除できません"
        end
      end


    private

    def admin_user
      if logged_in?
        unless current_user.admin
          redirect_to tasks_path ,notice: "管理者権限を持ったユーザでログインをしてください。"
        end
      elsif
        redirect_to tasks_path ,notice: "ログインをしてください。"
      end
    end
  
    def anotheradmin_check
      if User.admin_count == 1 and @user.admin
        return false
      else
        return true
      end
    end

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation,:user_image,:admin)
    end

    def set_user
      @user = User.find(params[:id])
    end

end
