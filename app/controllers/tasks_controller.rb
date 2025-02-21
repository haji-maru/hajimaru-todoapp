class TasksController < ApplicationController
  before_action :set_board, only: [:index, :show, :new, :create, :update]
  before_action :set_task, only: [:edit, :update]
  before_action :authenticate_user!

  def index
    @tasks = @board.tasks
  end

  def show
    @task = @board.tasks.find(params[:id])
    @comments = @task.comments
  end

  def new
    @task = @board.tasks.build
  end

  def create
    @task = @board.tasks.build(task_params)
    @task.user = current_user
    if @task.save
      redirect_to board_tasks_path(@board), notice: '保存できました'
    else
      flash.now[:error] = '保存に失敗しました'
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to board_tasks_path(@board), notice: '更新できました'
    else
      flash.now[:error] = '更新に失敗しました'
      render :edit
    end
  end

  def destroy
    task = current_user.tasks.find(params[:id])
    task.destroy!
    redirect_to board_tasks_path(task.board), notice: '削除できました'
  end

  private
  def task_params
    params.require(:task).permit(:title, :content, :due_date, :eyecatch)
  end

  def set_board
    @board = Board.find(params[:board_id])
  end

  def set_task
    @task = current_user.tasks.find(params[:id])
  end
end