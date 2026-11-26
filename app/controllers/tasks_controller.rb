class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]

 def index
  @tasks = current_user.tasks.where(archived: false)
 end

 def archive
  @tasks = current_user.tasks.where(archived: true)
 end

  def show
  end

  def edit
  end

  def new
    @task = current_user.tasks.build # build creates an object
    # hindi pa i sasave sa Db
  end

  def create
    @task = current_user.tasks.build(task_params) # create task object

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: "Task was successfully created." }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @task.errors, status: :unprocessable_content }
      end
    end
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: "Task was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @task.errors, status: :unprocessable_content }
      end
    end
  end

  def destroy
    @task.destroy!

    respond_to do |format|
      format.html { redirect_to tasks_path, notice: "Task was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  def archive_task
  @task = current_user.tasks.find(params[:id])

   if @task.update(archived: true)
     redirect_to tasks_path, notice: "Task archived successfully."
   else
     render :show, status: :unprocessable_entity
   end
  end

  def restore
    @task = current_user.tasks.find(params[:id])
    @task.update(archived: false)

    redirect_to archive_tasks_path, notice: "Task restored successfully."
  end

  private

  def set_task
    @task = current_user.tasks.find(params.expect(:id))
  end

  def task_params
    params.expect(task: [ :title, :description, :status ])
  end
end
