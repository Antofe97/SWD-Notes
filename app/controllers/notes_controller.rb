class NotesController < ApplicationController

  before_action :admin_permission, only: [:user_notes]

  def index
      @notes = Note.where(user_id: current_user.id)
  end

  #admin_management
  def user_notes
    @notes = Note.where(user_id: params[:id])
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
      redirect_to @note
    else
      render :new
    end
  end

  def edit
    @note = Note.find(params[:id])
    @collections = current_user.collections
    if @note.user_id == current_user.id || is_admin?

    else
      redirect_to notes_path
    end
  end

  def update
    @note = Note.find(params[:id])

    if @note.update(note_params)
      redirect_to @note
    else
      render :edit
    end
  end

  def destroy
    @note = Note.find(params[:id])
    @note.destroy

    redirect_to notes_path
  end

  private
    def note_params
      params.require(:note).permit(:title, :body, :image, :user_id, :collection_id)
    end
  
end
