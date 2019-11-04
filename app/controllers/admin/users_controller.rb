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
        @user.destroy
        redirect_to admin_users_path, notice:"ユーザーを削除しました！"
      end


    private
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation,:user_image)
    end

    def set_user
      @user = User.find(params[:id])
    end

    def admin_user
      flash[:success] = "権限がありません"
      redirect_to(root_path) unless current_user.admin?
    end

end
