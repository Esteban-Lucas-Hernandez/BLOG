class TasksController < ApplicationController
  def create
    @project = Project.find(params[:task][:project_id])
    @task = @project.tasks.build(task_params)
    if @task.save
      redirect_to @project, notice: 'Task was successfully created.'
    else
      redirect_to @project, alert: "Failed to create task: #{@task.errors.full_messages.join(', ')}"
    end
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to @task.project, notice: 'Task was successfully updated.'
    else
      redirect_to @task.project, alert: "Failed to update task: #{@task.errors.full_messages.join(', ')}"
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @project = @task.project
    @task.destroy
    redirect_to @project, notice: 'Task was successfully deleted.'
  end

  private

  def task_params
    params.require(:task).permit(:title, :done, :due_date, :project_id)
  end
end
