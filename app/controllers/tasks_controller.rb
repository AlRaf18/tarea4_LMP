class TasksController < ApplicationController
  before_action :check_session

  def check_session
    redirect_to :init_session if cookies[:session].nil?
  end

  def index
    # Se mostraran en la tabla todas las tareas ordenadas
    # ascendentemente respecto al nombre del encargado
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
    # Se crea instancia del objeto task
    @object = Task.new(controller_params)
    @object.attendant = cookies[:session]
    @object.completed = false
    # Se guarda en base de datos, y a su vez se verifica
    # la existencia de algun error
    if @object.save
      # En caso de no haber errores, hace el redirect
      # al path donde se ven todas las tareas
      redirect_to "/#{controller_path}"
    else
      # En caso de existir algun error, manda a new, el
      # cual hace el render del form nuevamente junto con
      # los errores encontados (Se maneja en la vista)
      render 'new'
    end
  end

  def destroy
    # Se busca el objeto a eliminar por su id
    @object = Task.all.find(params[:id])

    # Se elimina
    @object.destroy

    # Redirect al path de tareas
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
