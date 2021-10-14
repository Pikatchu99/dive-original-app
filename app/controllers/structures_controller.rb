class StructuresController < ApplicationController
  before_action :set_structure, only: %i[ show edit update destroy ]
  require "uri"
  require "net/http"

  # GET /structures or /structures.json
  def index
    @structures = Structure.all
    current_user_location = request.location.city
    puts current_user_location
    latitude = params[:l]
    longitude = params[:L]
    url = URI("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{latitude},#{longitude}&radius=10000&type=pharmacy&keyword=pharmacy&key=AIzaSyAy_9GkemEqUHh4ueMlxhJOmqJLInzsKRM")
    puts url
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Get.new(url)

    response = https.request(request).read_body
    response = JSON.parse(response)

    @results = response["results"]
    @results.each do |result|
      structure = Structure.find_by(place_id: result["place_id"])
      if structure.nil?
        Structure.create!(place_id: result["place_id"], name: result["name"])
      end
    end



    respond_to do |format|
      format.html {}
      format.json {render json: @results}
    end

    # puts response.read_body
  end

  # GET /structures/1 or /structures/1.json
  def show
  end

  # GET /structures/new
  def new
    @structure = Structure.new
  end

  # GET /structures/1/edit
  def edit
  end

  # POST /structures or /structures.json
  def create
    @structure = Structure.new(structure_params)

    respond_to do |format|
      if @structure.save
        format.html { redirect_to @structure, notice: "Structure was successfully created." }
        format.json { render :show, status: :created, location: @structure }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @structure.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /structures/1 or /structures/1.json
  def update
    respond_to do |format|
      if @structure.update(structure_params)
        format.html { redirect_to @structure, notice: "Structure was successfully updated." }
        format.json { render :show, status: :ok, location: @structure }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @structure.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /structures/1 or /structures/1.json
  def destroy
    @structure.destroy
    respond_to do |format|
      format.html { redirect_to structures_url, notice: "Structure was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_structure
      @structure = Structure.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def structure_params
      params.require(:structure).permit(:name, :contact, :email, :variety)
    end
end
