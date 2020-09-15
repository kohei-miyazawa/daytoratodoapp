class TasksController < ApplicationController

  def show

  end

  def new
    @task = current_user.tasks.build
    @board = Board.find_by(id: params[:board_id])
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to root_path, notice: 'taskを作成しました'
    else
      flash.now[:error] = 'taskの作成に失敗しました'
      render :new
    end
  end

  private
    def task_params
      params.require(:task).permit(:title, :content, :board_id)
    end
end
