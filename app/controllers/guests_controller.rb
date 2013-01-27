class GuestsController < ApplicationController
    # GET /guests
    # GET /guests.json
    def index
        @guest = Guest.new
        @guests = Guest.all

        respond_to do |format|
            format.html #index.html.erb
            format.json { render json: @guests }
        end
    end

    # GET /guests/1
    # GET /guests/1.json
    def show
        @guest = Guest.find(params[:id])

        respond_to do |format|
            format.html #index.html.erb
            format.json { render json: @guest }
        end
    end

    def create
        #render :text => params.inspect
        Guest.create params[:guest]
        # if @guest.save
        #     format.html { redirect_to @guest, notice: 'Guest was successfully created.' }
        #     format.json { render json: @guest, status: :created, location: @guest }
        # else
        #     format.html { render action: "new" }
        #     format.json { render json: @guest.errors, status: :unprocessable_entity }
        # end
        redirect_to guests_path
    end

    # GET /guests/new
    def new
          @guest = Guest.new
          respond_to do |format|
            format.html #index.html.erb
            format.json { render json: @guests }
        end
    end

    def edit
        @guest = Guest.find params[:id]
    end

    def update
        guest = Guest.find params[:id]
        if guest.update_attributes params[:guest]
            redirect_to guests_path, :notice => 'Your guest has successfully been updated.'
        else
            redirect_to :back, :notice => 'There was an error updating your guest.'
        end
    end

    def destroy
        Guest.destroy params[:id]
        redirect_to :back, :notice => 'Guest has been deleted.'
    end
end
