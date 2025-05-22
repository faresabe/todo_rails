class TasksController < ApplicationController
    before_action :set_task, only: %i[show edit update destroy]
    before_action :require_login
  
  
    def index
      @user = User.find(session[:user_id])
      @tasks = @user.tasks
    end
  
    
    def show
    end
  
  
    def new
      @task = Task.new
    end
  
  
    def edit
    end
  
   
    def create
      @task = Task.new(task_params)
      @task.user = User.find(session[:user_id])
  
      respond_to do |format|
        if @task.save
          format.html { redirect_to @task, notice: "Task was successfully created." }
          format.json { render :show, status: :created, location: @task }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @task.errors, status: :unprocessable_entity }
        end
      end
    end
  
    def update
      respond_to do |format|
        if @task.update(task_params)
          format.html { redirect_to @task, notice: "Task was successfully updated." }
          format.json { render :show, status: :ok, location: @task }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @task.errors, status: :unprocessable_entity }
        end
      end
    end
  
    
    def destroy
      @task.destroy!
  
      respond_to do |format|
        format.html { redirect_to tasks_path, status: :see_other, notice: "Task was successfully destroyed." }
        format.json { head :no_content }
      end
    end
  
    private
  
   
    def set_task
      @task = Task.find(params[:id])
    end
  
    
    def task_params
      params.require(:task).permit(:title)
    end
end
  