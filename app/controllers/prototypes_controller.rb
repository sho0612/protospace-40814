class PrototypesController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_prototype, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user, only: [:edit, :update, :destroy]

  def index
    @prototypes = Prototype.all
  end

  def destroy
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    @prototype.user = current_user
    if @prototype.save
      redirect_to action: :index, notice: 'Prototype was successfully created.'
    else
      render :new
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comments = @prototype.comments.includes(:user) 
  end

  def edit
    @prototype = Prototype.find(params[:id])
  end

  def update
    if @prototype.update(prototype_params)
      redirect_to @prototype, notice: 'Prototype was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @prototype.destroy
    redirect_to prototypes_path, notice: 'Prototype was successfully destroyed.'
  end


  private

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def authorize_user
    unless user_signed_in? && @prototype.user == current_user
      redirect_to action: :index, alert: 'You are not authorized to perform this action.'
    end
  end

  def prototype_params
    #params.require(:prototype).permit(:title, :catch_copy, :concept).merge(user: current_user)
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end
  
end
