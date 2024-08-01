class TasksController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create, :update, :destroy]

  # Class variable to hold tasks in memory
  @@tasks = [
    { id: 1, name: 'Buy groceries', completed: false },
    { id: 2, name: 'Read a book', completed: true },
    { id: 3, name: 'Go for a run', completed: false }
  ]

  # GET /tasks
  def index
    render json: @@tasks
  end

  # POST /tasks
  def create
    task = { id: next_id, name: task_params[:name], completed: task_params[:completed] }
    @@tasks << task
    render json: task, status: :created
  end

  # PUT /tasks/:id
  def update
    task = find_task(params[:id])
    if task
      task[:name] = task_params[:name] if task_params[:name]
      task[:completed] = task_params[:completed] unless task_params[:completed].nil?
      render json: task
    else
      render json: { error: 'Task not found' }, status: :not_found
    end
  end

  # DELETE /tasks/:id
  def destroy
    task = find_task(params[:id])
    if task
      @@tasks.delete(task)
      head :no_content
    else
      render json: { error: 'Task not found' }, status: :not_found
    end
  end

  private

  def find_task(id)
    @@tasks.find { |task| task[:id] == id.to_i }
  end

  def next_id
    (@@tasks.map { |task| task[:id] }.max || 0) + 1
  end

  def task_params
    params.permit(:name, :completed)
  end
end