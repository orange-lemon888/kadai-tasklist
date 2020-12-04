class TasksController < ApplicationController
    before_action :require_user_logged_in
    #1203追加
    before_action :correct_user, only: [:show, :edit, :update, :destroy]
  
    def index
      @tasks = current_user.tasks
    end
    
    def show
    end
    
    def new
      @task = Task.new
    end
    
    def create
      @task = current_user.tasks.build(task_params)
      
      if @task.save
        flash[:success] = 'Taskが正常に投稿されました'
        redirect_to @task
      else
        flash.now[:danger] = 'Taskが投稿されませんでした'
        render :new
      end
    end
    
    def edit
    end
    
    def update
      if @task.update(task_params)
        flash[:success] = 'Taskは正常に更新されました'
        redirect_to @task
      else
        flash.now[:danger] = 'Taskが更新されませんでした'
        render :edit
      end  
    end
    
    def destroy
      @task.destroy
      
      flash[:success] = 'Task は正常に削除されました'
      redirect_to tasks_url
    end
    
    private
    #1203===========54行目エラーになる（一覧から新規投稿クリック時）
    def correct_user
      @task = current_user.tasks.find_by(id: params[:id])
      unless @task
        redirect_to root_url
      end
    end
    #===============
    
    # def set_task
    #   @task = Task.find(params[:id]) 
    # end
    
    #Strong Parameter
    def task_params
      params.require(:task).permit(:content, :status)
    end
end
