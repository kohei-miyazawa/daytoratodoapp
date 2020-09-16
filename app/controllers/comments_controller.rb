class CommentsController < ApplicationController
  def new
    @comment = current_user.comments.build
    @task = Task.find_by(id: params[:task_id])
    @board = Board.find_by(id: params[:board_id])
  end

  def create
    @task = Task.find_by(id: params[:task_id])
    @board = Board.find_by(id: params[:board_id])
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      redirect_to board_task_path(@board, @task), notice: 'commentを作成しました'
    else
      flash.now[:error] = 'commentの作成に失敗しました'
      render :new
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:body, :task_id, :board_id)
    end
end
