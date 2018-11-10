class StepsController < ApplicationController
  before_action :set_step, only: [:show, :edit, :update, :destroy]

  # GET /steps
  # GET /steps.json
  def index
    @steps = Step.all

  end

  # GET /steps/1
  # GET /steps/1.json
  def show
  end

  # GET /steps/new
  def new
    @step = Step.new
  end

  # GET /steps/1/edit
  def edit
  end

  # POST   /deeds/:deed_id/steps
  def create
    state = step_params[:state]
    if state.blank?
      redirect_to "/deeds/#{params[:deed_id]}"
      return 
    end
    @deed = Deed.find(params[:deed_id])
    step = @deed.steps.build(step_params)
    step.user = current_user
    @deed.state = step.state

    # p Deed.states[state], 'bjbjhb'

    @deed.start_date = Date.today if @deed.start_date.blank? && [1, 2].include?(Deed.states[state])
    # end

    respond_to do |format|
      if @deed.save
        # real_estate = User.find(@deed.real_estate)
        # lawyer = User.find(@deed.lawyer)
        DeedMailer.step_change_email(@deed).deliver_later if @deed.start_date.blank? && [1, 2].include?(Deed.states[state])# if @deed.state == 'Carátula conservador'

        format.html { redirect_to @deed, notice: 'Estado fue exitosamente creado' }
        format.json { render :show, status: :created, location: @step }
      else
        p @deed.errors
        format.html { redirect_to @deed, notice: 'Estado no pudo ser agregado' }
        format.json { render json: @step.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /steps/1
  # PATCH/PUT /steps/1.json
  def update
    respond_to do |format|
      if @step.update(step_params)
        format.html { redirect_to @step, notice: 'Step was successfully updated.' }
        format.json { render :show, status: :ok, location: @step }
      else
        format.html { render :edit }
        format.json { render json: @step.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /deeds/:deed_id/steps/:id
  def destroy
    # puts deed_url
    @step.destroy
    id = params[:deed_id]
    respond_to do |format|
      format.html { redirect_to "/deeds/#{id}", notice: 'Estado fue exitosamente eliminado.' }
      # format.html { render 'deeds/show', notice: 'Estado fue exitosamente eliminado.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_step
    @step = Step.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def step_params
    params.require(:step).permit(:user_id, :deed_id, :executed_on, :state)
  end
end
