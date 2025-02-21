class CommentsController < ApplicationController
  before_action :set_task, only: [:new, :create]

  def new
    @comment = @task.comments.build
  end

  def create
    @comment = @task.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to board_task_path(@task.board, @task), notice: 'コメントを追加しました'
    else
      flash.now[:error] = '保存に失敗しました'
      render :new
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_task
    @task = Task.find(params[:task_id])
  end
end