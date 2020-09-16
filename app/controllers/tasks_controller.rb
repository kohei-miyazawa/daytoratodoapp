class TasksController < ApplicationController

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = current_user.tasks.build
    @board = Board.find_by(id: params[:board_id])
  end

  def create
    @board = Board.find_by(id: params[:board_id])
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to root_path, notice: 'cardを作成しました'
    else
      flash.now[:error] = 'cardの作成に失敗しました'
      render :new
    end
  end

  private
    def task_params
      params.require(:task).permit(:title, :content, :board_id, :eyecatch)
    end
end
