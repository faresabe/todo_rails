class TasksController < ApplicationController
    before_action :require_login
before_action :set_task, only: [:show, :edit, :update, :destroy]

def index
  @tasks = current_user.tasks
end

private

def set_task
  @task = current_user.tasks.find(params[:id])
end
end
