class ContainersController < ApplicationController
  before_action :set_container, only: [:show, :edit, :update, :destroy, :start, :stop]
  before_action :init_images, only: [:new, :edit]

  # GET /containers
  # GET /containers.json
  def index
    @containers = Container.all.order("created_at desc").to_a.each do |c|
      if Docker::Container.get(c.cid).json['State']['Running'] == true
        c.json = 'running'
      end
    end
  end

  def start
    Docker::Container.get(@container.cid).start
    redirect_to action: 'index'
  end

  def stop
    Docker::Container.get(@container.cid).stop
    redirect_to action: 'index'
  end

  # GET /containers/1
  # GET /containers/1.json
  def show
    @container.json = Docker::Container.get(@container.cid)
  end

  # GET /containers/new
  def new
    @container = Container.new
  end

  # GET /containers/1/edit
  def edit
  end

  # POST /containers
  # POST /containers.json
  def create
    @container = Container.new(container_params)
    @container.user = current_user

    container_params = @container.param.split(/[\r\n]+/)

    c = Docker::Container.create(
      'Image' => @container.image,
      'Cmd' => container_params,
      'PublishAllPorts' => true,
      'name' => @container.name
    )

    c.start

    @container.cid = c.id
    respond_to do |format|
      if @container.save
        format.html { redirect_to @container, notice: 'Container was successfully created.' }
        format.json { render :show, status: :created, location: @container }
      else
        format.html { render :new }
        format.json { render json: @container.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /containers/1
  # PATCH/PUT /containers/1.json
  def update
    respond_to do |format|
      if @container.update(container_params)
        format.html { redirect_to @container, notice: 'Container was successfully updated.' }
        format.json { render :show, status: :ok, location: @container }
      else
        format.html { render :edit }
        format.json { render json: @container.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /containers/1
  # DELETE /containers/1.json
  def destroy
    container = Docker::Container.get(@container.cid)
    container.delete(:force => true)

    @container.destroy
    respond_to do |format|
      format.html { redirect_to containers_url, notice: 'Container was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_container
      @container = Container.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def container_params
      params.require(:container).permit(:name, :image, :param)
    end
    def init_images
      @images = (Docker::Image.all || []).map {|i| i.info['RepoTags'][0]}
    end
end
