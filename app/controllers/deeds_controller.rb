class DeedsController < ApplicationController
  # before_action :check_auth_deed, only: [:show, :edit, :update, :destroy]

  before_action :set_deed, only: [:show, :edit, :update, :destroy, :change_state, :delete_state]
  before_action :set_steps, only: [:show, :change_state]
  before_action :authenticate_user!
  protect_from_forgery with: :null_session, only: [:update]

  # GET /deeds
  # GET /deeds.json
  def index
    @deeds = current_user.deeds
    return if params[:query].nil?

    @q = params[:query]
    # @deeds1 = 
    @deeds = []
    current_user.deeds.each do |deed|
      if deed.identifier.downcase.include?(@q.downcase) || deed.state.downcase.include?(@q.downcase)
        @deeds << deed
      end
    end
  end

  # GET /deeds/1
  # GET /deeds/1.json
  def show
    # @steps = @deed.steps
  end

  # GET /deeds/new
  def new
    @deed = Deed.new
  end

  # GET /deeds/1/edit
  def edit; end

  # POST /deeds
  # POST /deeds.json
  def create
    # @deed = current_user.deeds.build(deed_params)
    @deed = Deed.new(deed_params)
    @deed.real_estate = current_user
    @lawyer = User.find_by(email: params[:lawyer_mail])

    @deed.lawyers << @lawyer if @lawyer

    @deed.steps.build(state: 0, user: current_user)

    respond_to do |format|
      if @lawyer
        if @deed.save
          # p 'acaaa que wa'
          DeedMailer.new_deed(@deed).deliver_later
          format.html { redirect_to @deed, notice: 'Escritura fue creada exitosamente.' }
          format.json { render :show, status: :created, location: @deed }
        else
          format.html { render :new }
          format.json { render json: @deed.errors, status: :unprocessable_entity }
        end
      else
        flash.now[:notice] = 'Email ingresado no existe en el sistema'
        format.html { render :new, notice: 'Email ingresado no existe en el sistema' }
        format.json { render json: @deed.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /deeds/1
  # PATCH/PUT /deeds/1.json
  def update
    add_auth params[:new_authorized_email], params[:id]

    respond_to do |format|
      if @deed.update(deed_params)
        format.html { redirect_to @deed, notice: 'Escritura fue editada exitosamente.' }
        format.json { render :show, status: :ok, location: @deed }
      else
        format.html { render :edit }
        format.json { render json: @deed.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /deeds/1
  # DELETE /deeds/1.json
  def destroy
    @deed.destroy
    respond_to do |format|
      format.html { redirect_to deeds_url, notice: 'Escritura fue eliminada exitosamente.' }
      format.json { head :no_content }
    end
  end

  # POST /deeds/1
  def change_state
    info = step_params
    unless info[:state] == ''
      step = @deed.steps.build(info)
      step.user = current_user
      @deed.state = step.state
      @deed.save
    end
    @steps = Step.where(deed: @deed)
    render @deed # 'deeds/show'
  end

  def old
    if params[:query].nil?
      @deeds = current_user.deeds
    else
      @q = params[:query]
      @deeds1 = current_user.deeds
      @deeds = []

      @deeds1.each do |deed|
        if deed.identifier.downcase.include?(@q.downcase) || deed.state.downcase.include?(@q.downcase)
          @deeds << deed
        end
      end
    end
  end

  # DELETE /deeds/1/steps/1
  # def delete_state
  #   step = Step.find(params[:step_id])
  #   redirect_to deed_path, notice: "Estado '#{step.state}' fue eliminado."
  # end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_deed
    @deed = Deed.find(params[:id])
  end

  def set_steps
    @steps = @deed.steps
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def deed_params
    params.require(:deed).permit(:state, :start_date, :duration, :lawyer_mail, :identifier, :new_authorized_email)
  end

  def step_params
    params.require(:step).permit(:user_id, :executed_on, :state, :identifier)
  end

  def check_auth_deed
    @deed = Deed.find(params[:id])
    @user = User.find(current_user.id)
    @is_included = false
    @user.deeds.each do |deed|
      # @is_included = true if deed.id == @deed.id
      if deed.id == @deed.id
        @is_included = true
        next
      end
    end
    return if @is_included
    flash[:notice] = 'Acceso denegado. Usted no está autorizado para ver o editar esta escritura'
    redirect_to deeds_path
  end

  def add_auth(other_user_mail, deed_id)
    # puts 'HIIIIII', other_user_mail, deed_id, params[:new_authorized_email]
    @deed = Deed.find(deed_id)
    @other_user = User.find_by(email: other_user_mail)

    @is_included = false
    if @other_user
      @other_user.deeds.each do |deed|
        if deed.id == @deed.id
          @is_included = true
        end
      end

    end
    unless !@other_user || @is_included
      @deed.lawyer << @other_user
      flash[:notice] = 'Authorization granted'
    end
  end

end
