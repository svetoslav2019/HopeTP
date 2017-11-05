class NotesController < ApplicationController
 
  
  def index
    @notes = Note.all
  end

  def show
    @note = Note.find_by slug: params[:slug]
    if @note.nil?
      render "note_gone"
    else
      @note.destroy
    end
  end

  def new
    @note = Note.new
  end
  
  def edit
  end

  def create
    if request.content_type =~ /xml/
      params[:message] = Hash.from_xml(request.body.read)["message"]
      ting = Note.create(content: params[:message])
      render xml:
      '<?xml version = "1.0" encoding = "UTF-8" standalone = "yes"?>' +
      '<url>' +
        notes_url + ting.slug + "/info" +
      '</url>'
    elsif request.content_type =~ /json/
		#pitame dali stringa e raven na nqkuv drug regex;
      ting = Note.new(content: params[:message])
      render json: {url: notes_url + ting.slug + '/info'}
    elsif request.content_type =~ /form/
      @note = Note.new({content: params[:content]})
      if @note.save
        redirect_to notes_url + @note.slug + '/info'
      else
        render 'index'
      end
    end
    
  end

  def info
    render "note_url_info", locals: {url: notes_url + "/" + params[:slug]}
		#renderva se html-a da dade link;
  end

  def update
    respond_to do |format|
      if @note.update(note_params)
        format.html { redirect_to @note, notice: 'Aktoalizirahte zapeskata.' }
        format.json { render :show, status: :ok, location: @note }
      else
        format.html { render :edit }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
	#generirano e ot scaffolda.
    end
  end

  def destroy
    @note.destroy
    respond_to do |format|
      format.html { redirect_to notes_url, notice: 'Ospe6mo istrihte zapiskata.' }
      format.json { head :no_content }
    end
  end

  private

    def set_note
      @note = Note.find(params[:slug])
#ne moje da se dostupva nikude osven v samiq file
    end

    def note_params
      params.require(:note).permit(:content)
    end
     def note_api_params
      params.permit(:content)
    end
end
