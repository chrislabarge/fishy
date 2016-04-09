class LightsController < ApplicationController
  before_action :set_light, only: [:show, :edit, :update, :destroy]

  # GET /lights
  # GET /lights.json
  def index
    @lights = Light.all   
  end

  # GET /lights/1
  # GET /lights/1.json
  def show
  end

  # GET /lights/new
  def new
    color = nil

    if params[:light] == 'blue'
      reset_strip
      system("pigs p 24 250 && pigs p 22 200")
    elsif params[:light] == 'green'
      reset_strip
      system("pigs p 22 250")
    elsif params[:light] ==  'red'
      reset_strip
      system("pigs p 17 250")
    elsif params[:light] ==  'yellow'
      reset_strip
      system("pigs p 22 100 && pigs p 17 250")
    else
      reset_strip
      system("pigs p 22 250 && pigs p 17 250 && pigs p 24 250")
    end  

    redirect_to lights_path(color: 'blue')
  end

  def reset_strip
    system("pigs p 22 0 && pigs p 17 0 && pigs p 24 0")
  end

  # GET /lights/1/edit
  def edit
  end

  # POST /lights
  # POST /lights.json
  def create
    @light = Light.new(light_params)

    respond_to do |format|
      if @light.save
        format.html { redirect_to @light, notice: 'Light was successfully created.' }
        format.json { render :show, status: :created, location: @light }
      else
        format.html { render :new }
        format.json { render json: @light.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lights/1
  # PATCH/PUT /lights/1.json
  def update
    respond_to do |format|
      if @light.update(light_params)
        format.html { redirect_to @light, notice: 'Light was successfully updated.' }
        format.json { render :show, status: :ok, location: @light }
      else
        format.html { render :edit }
        format.json { render json: @light.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lights/1
  # DELETE /lights/1.json
  def destroy
    @light.destroy
    respond_to do |format|
      format.html { redirect_to lights_url, notice: 'Light was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_light
      @light = Light.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def light_params
      params.fetch(:light, {})
    end
end
