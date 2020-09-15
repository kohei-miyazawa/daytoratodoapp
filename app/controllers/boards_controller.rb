class BoardsController < ApplicationController
  def index
    @boards = Board.all
  end

  def new
    @board = current_user.boards.build
  end

  def create
    @board = current_user.boards.build(board_params)
    if @board.save
      redirect_to root_path, notice: 'boardを作成しました'
    else
      flash.now[:error] = 'boradの作成に失敗しました'
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
    def board_params
      params.require(:board).permit(:name, :description)
    end
end
