class TasksController < ApplicationController
  before_action :set_task, only: [:edit, :update]
  before_action :authenticate_user!

  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = current_user.tasks.build
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to tasks_path, notice: '保存できました'
    else
      flash.now[:error] = '保存に失敗しました'
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to task_path, notice: '更新できました'
    else
      flash.now[:error] = '更新に失敗しました'
      render :edit
    end
  end

  def destroy
    task = current_user.tasks.find(params[:id])
    task.destroy!
    redirect_to task_path, notice: '削除できました'
  end

  private
  def task_params
    params.require(:task).permit(:title, :content, :due_date)
  end

  def set_task
    @task = current_user.tasks.find(params[:id])
  end
end