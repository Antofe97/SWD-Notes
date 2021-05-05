class NotesController < ApplicationController
  add_flash_types :danger, :info, :warning, :success, :notice

  before_action :admin_permission, only: [:user_notes,:collection_notes]

  def index
      @notes = Note.where(user_id: current_user.id)
  end

  #admin_management
  def user_notes
    
    if is_admin?
      @notes = Note.where(user_id: params[:id])
    else
      flash[:danger] = "Unauthorized" 
    end 
  end

  def collection_notes
    @notes = Note.where(collection_id: params[:id_collection])
  end

  def show
    @note = Note.find(params[:id])

    if @note.collection_id == nil

    else  
      @collection = Collection.find(@note.collection_id)
    end

    if @note.user_id == current_user.id || is_admin?

    else 
      flash[:danger] = "Unauthorized" 
      redirect_to notes_path
    end
  end


  def new
    @note = Note.new
    @collections = current_user.collections
    
  end

  def create
    @note = Note.new(note_params)

    @note.user_id = current_user.id

    if @note.save
      flash[:success] =  "Note was successfully created."
      redirect_to @note
    else
      flash[:danger] = "There was a problem, try again." 
      render :new
    end
  end

  def edit
    @note = Note.find(params[:id])
    @collections = current_user.collections
    if @note.user_id == current_user.id || is_admin?

    else
      flash[:danger] = "Unauthorized" 
      redirect_to notes_path
    end
  end

  def update
    @note = Note.find(params[:id])

    if @note.update(note_params)
      flash[:info] =  "Note was successfully updated."
      redirect_to @note
    else
      flash[:danger] = "There was a problem, try again." 
      render :edit
    end
  end

  def destroy
    @note = Note.find(params[:id])
    @note.destroy
    flash[:danger] = "The note was successfully destroyed." 
    redirect_to notes_path
  end

  private
    def note_params
      params.require(:note).permit(:title, :body, :image, :user_id, :collection_id)
    end
  
end
