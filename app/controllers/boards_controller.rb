class BoardsController < ApplicationController
  before_action :set_board, only: [:edit, :update]

  def index
    @boards = Board.all
  end

  def new
    @board = current_user.boards.build
  end

  def create
    @board = current_user.boards.build(board_params)
    if @board.save
      redirect_to boards_path, notice: '保存できました'
    else
      flash.now[:error] = '保存に失敗しました'
      render :new
    end
  end

  def edit
  end

  def update
    if @board.update(board_params)
      redirect_to boards_path, notice: '更新できました'
    else
      flash.now[:error] = '更新に失敗しました'
      render :edit
    end
  end

  def destroy
    board = current_user.boards.find(params[:id])
    board.destroy!
    redirect_to boards_path, notice: '削除できました'
  end

  private
  def board_params
    params.require(:board).permit(:title, :content)
  end

  def set_board
    @board = current_user.boards.find(params[:id])
  end
end
