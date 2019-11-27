class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @task = Task.new
    if logged_in?
      @tasks =Task.where(user_id: current_user.id).page(params[:page]).list(params)
    else
      redirect_to new_session_path
    end
  end

  def new
    @task = Task.new
    @tag = Tag.all
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to task_path(@task.id), notice: "ブログを作成しました！"
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "タスクを編集しました！"
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice:"ブログを削除しました！"
  end

  private

  def task_params
    params.require(:task).permit(:name, :content, :expiration_date, :state, :priority, :user_id, {tag_ids: []} )
  end

  def set_task
    @task = Task.find(params[:id])
  end

end
