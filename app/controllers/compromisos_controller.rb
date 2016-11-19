class CompromisosController < ApplicationController
  before_action :set_compromiso, only: [:show, :edit, :update, :destroy]

  # GET /compromisos
  # GET /compromisos.json
  def index
    @compromisos = Compromiso.all
  end

  # GET /compromisos/1
  # GET /compromisos/1.json
  def show
  end

  # GET /compromisos/new
  def new
    @compromiso = Compromiso.new
  end

  # GET /compromisos/1/edit
  def edit
  end

  # POST /compromisos
  # POST /compromisos.json
  def create
    @compromiso = Compromiso.new(compromiso_params)

    respond_to do |format|
      if @compromiso.save
        format.html { redirect_to @compromiso, notice: 'Compromiso was successfully created.' }
        format.json { render :show, status: :created, location: @compromiso }
      else
        format.html { render :new }
        format.json { render json: @compromiso.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /compromisos/1
  # PATCH/PUT /compromisos/1.json
  def update
    respond_to do |format|
      if @compromiso.update(compromiso_params)
        format.html { redirect_to @compromiso, notice: 'Compromiso was successfully updated.' }
        format.json { render :show, status: :ok, location: @compromiso }
      else
        format.html { render :edit }
        format.json { render json: @compromiso.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /compromisos/1
  # DELETE /compromisos/1.json
  def destroy
    @compromiso.destroy
    respond_to do |format|
      format.html { redirect_to compromisos_url, notice: 'Compromiso was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_compromiso
      @compromiso = Compromiso.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def compromiso_params
      params.require(:compromiso).permit(:nombre, :apellido, :email, :ciudad_origen, :edad, :compromiso)
    end
end
