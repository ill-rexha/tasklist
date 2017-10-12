class TasksController < ApplicationController
  before_action :get_task, only:[:show,:edit,:update,:destroy]

  def index
    @tasks = Task.all
  end

  def show
    # 選んだ際にshowは使われるため、idがないといけない
    # taskは１つしか選択されないので、単数の@taskにする
    # @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(strong_params)

    if @task.save
      flash[:success] = "タスクは保存されました"
      redirect_to @task
    else
      flash.now[:danger] = "タスクは保存されませんでした"
      render :new
    end
  end

  def edit
    # @task = Task.find(params[:id])
  end

  def update
    # @task = Task.find(params[:id])
    # form_forに入力に失敗した文字列が入る仕様のため
    if @task.update(strong_params)
      flash[:success] = "タスクは無事更新されました"
      redirect_to @task
    else
      flash.now[:danger] = "タスクは更新されませんでした"
      render :edit
    end

  end

  def destroy
    # @task = Task.find(params[:id])
    @task.destroy
    flash[:success] = "タスクは無事削除されました"
    redirect_to tasks_url
  end

  private

    def strong_params
      params.require(:task).permit(:content,:status)
    end

    def get_task
      @task = Task.find(params[:id])
    end
end
