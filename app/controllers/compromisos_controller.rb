class CompromisosController < ApplicationController
  before_action :set_compromiso, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token
  before_action :set_access, only: [:create]
  before_action :authenticate, except: [:create, :dame_datos_grafica]

  # GET /compromisos
  # GET /compromisos.json
  def index
    @compromisos = Compromiso.all
    @conteo = cuenta_compromisos
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
    if Compromiso.find_by_email(compromiso_params[:email]).present?#este chequeo se debe hacer en el modelo ¬¬
      render json: {:a => "No te has podido comprometer, el email ya existe, puedes usar otro si lo deseas"}.to_json
    else
      if @compromiso.save
        render json: {:a => "¡Te has comprometido!"}.to_json
      else
        render json: {:a => "No te has podido comprometer, hubo un error en nuestro sistema, intenta más tarde"}.to_json
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

  def dame_datos_grafica
    render json:cuenta_compromisos.to_json
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

  def set_access
    response.headers["Access-Control-Allow-Origin"] = request.headers["HTTP_ORIGIN"] if request.headers["HTTP_ORIGIN"].include?("biodiversidad.gob.mx")
    response.headers["Access-Control-Allow-Origin"] = "*" if request.headers["HTTP_ORIGIN"].include?("ggonzalez")
  end

  def cuenta_compromisos
    compromisos = Compromiso.all.map(&:compromiso)
    (0..4).map{|k| compromisos.count{|x| (x.to_i&(2**k))>0} }
  end
end
