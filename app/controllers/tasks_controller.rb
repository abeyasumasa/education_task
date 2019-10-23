class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @task = Task.new
    @tasks =Task.page(params[:page]).list(params)
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
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
    params.require(:task).permit(:name, :content, :expiration_date, :state, :priority)
  end

  def set_task
    @task = Task.find(params[:id])
  end

end
