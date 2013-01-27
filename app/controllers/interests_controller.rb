class InterestsController < ApplicationController
    # GET /interests
    # GET /interests.json
    def index
        @interest = Interest.new
        @interests = Interest.all

        respond_to do |format|
            format.html #index.html.erb
            format.json { render json: @interests }
        end
    end

    # GET /interests/1
    # GET /interests/1.json
    def show
        @interest = Interest.find(params[:id])

        respond_to do |format|
            format.html #index.html.erb
            format.json { render json: @interest }
        end
    end

    def create
        #render :text => params.inspect
        Interest.create params[:interest]
        # if @guest.save
        #     format.html { redirect_to @guest, notice: 'Guest was successfully created.' }
        #     format.json { render json: @guest, status: :created, location: @guest }
        # else
        #     format.html { render action: "new" }
        #     format.json { render json: @guest.errors, status: :unprocessable_entity }
        # end
        redirect_to interests_path
    end

    # GET /interests/new
    def new
          @interest = Interest.new
          respond_to do |format|
            format.html #index.html.erb
            format.json { render json: @interests }
        end
    end

    def edit
        @interest= Interest.find params[:id]
    end

    def update
        interest= Interest.find params[:id]
        if interest.update_attributes params[:guest]
            redirect_to interests_path, :notice => 'Your interest has successfully been updated.'
        else
            redirect_to :back, :notice => 'There was an error updating your interest.'
        end
    end

    def destroy
        Interest.destroy params[:id]
        redirect_to :back, :notice => 'Interest has been deleted.'
    end
end
