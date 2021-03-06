class TasksController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def show
    @task = Task.find(params[:id])
    @board = Board.find_by(id: params[:board_id])
    @comments = @task.comments
  end

  def new
    @task = current_user.tasks.build
    @board = Board.find_by(id: params[:board_id])
  end

  def create
    @board = Board.find_by(id: params[:board_id])
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to board_path(@board), notice: 'cardを作成しました'
    else
      flash.now[:error] = 'cardの作成に失敗しました'
      render :new
    end
  end

  def edit
    @task = current_user.tasks.find(params[:id])
    @board = Board.find_by(id: params[:board_id])
  end

  def update
    @board = Board.find_by(id: params[:task][:board_id])
    @task = current_user.tasks.find(params[:id])
    if @task.update(task_params)
      redirect_to board_task_path(@board, @task), notice: '更新しました'
    else
      flash.now[:error] = '更新できませんでした'
      render :edit
    end
  end

  def destroy
    board = Board.find_by(id: params[:board_id])
    task = current_user.tasks.find(params[:id])
    task.destroy!
    redirect_to board_path(board), notice: '削除に成功しました'
  end

  private
    def task_params
      params.require(:task).permit(:title, :content, :board_id, :eyecatch)
    end
end
