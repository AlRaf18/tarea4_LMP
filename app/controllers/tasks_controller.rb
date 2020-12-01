class TasksController < ApplicationController
  before_action :check_session

  def check_session
    redirect_to :init_session if cookies[:session].nil?
  end

  def index
    @filter_is_active = cookies[:filter]
    if @filter_is_active
      @objects = Task.all.where(attendant: cookies[:session])
    else
      @objects = Task.all
    end
    @completed_percentage = ((@objects.where(completed: true).count / @objects.count.to_f) * 100).round rescue "Aun no hay tareas"
    
  end

  def show
    @object = Task.all.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def edit
    @task = Task.all.find(params[:id])
  end

  def update
    @object = Task.all.find(params[:id])
    if @object.update_attributes(controller_params)
      redirect_to :action => :show
    else
      render 'edit'
    end
  end

  def create
    @object = Task.new(controller_params)
    @object.attendant = cookies[:session]
    @object.completed = false
    
    if @object.save
      redirect_to "/#{controller_path}"
    else
      render 'new'
    end
  end

  def destroy
    @object = Task.all.find(params[:id])
    @object.destroy

    redirect_to "/#{controller_path}"
  end

  def set_filter_cookie
    cookies[:filter] = true
    redirect_to "/#{controller_path}"
  end
  
  def delete_filter_cookie
    cookies.delete :filter
    redirect_to "/#{controller_path}"
  end
  
  def complete_task
    @object = Task.all.find(params[:id])
    @object.completed = true
    @object.save
    redirect_to "/#{controller_path}"
  end

  private

  def controller_params
    params.require(:task).permit(:title, :description, :attendant)
  end

end
