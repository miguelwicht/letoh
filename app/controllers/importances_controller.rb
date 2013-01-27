class ImportancesController < ApplicationController
    # GET /importances
    # GET /importances.json
    def index
        @importance = Importance.new
        @importances = Importance.all

        respond_to do |format|
            format.html #index.html.erb
            format.json { render json: @importances }
        end
    end

    # GET /importances/1
    # GET /importances/1.json
    def show
        @importance = Importance.find(params[:id])

        respond_to do |format|
            format.html #index.html.erb
            format.json { render json: @importance }
        end
    end

    def create
        #render :text => params.inspect
        Importance.create params[:importance]
        # if @guest.save
        #     format.html { redirect_to @guest, notice: 'Guest was successfully created.' }
        #     format.json { render json: @guest, status: :created, location: @guest }
        # else
        #     format.html { render action: "new" }
        #     format.json { render json: @guest.errors, status: :unprocessable_entity }
        # end
        redirect_to importances_path
    end

    # GET /importances/new
    def new
          @importance = Importance.new
          respond_to do |format|
            format.html #index.html.erb
            format.json { render json: @importances }
        end
    end

    def edit
        @importance= Importance.find params[:id]
    end

    def update
        importance= Importance.find params[:id]
        if importance.update_attributes params[:guest]
            redirect_to importances_path, :notice => 'Your importance has successfully been updated.'
        else
            redirect_to :back, :notice => 'There was an error updating your importance.'
        end
    end

    def destroy
        Importance.destroy params[:id]
        redirect_to :back, :notice => 'Importance has been deleted.'
    end
end
