class GuestsController < ApplicationController
    protect_from_forgery :except => :create
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


        if (params[:last_name] && params[:first_name])
            Guest.find_or_initialize_by_first_name_and_last_name(
                 params[:first_name], params[:last_name]
                 ).tap do |a|
                    a.birthday = params[:birthday]
                    a.current_city = params[:current_city]
                    a.tracker_id = params[:tracker_id]
                    @guest = a
                end.save!

            #@importance = {:interest_id => params[:interest_id], :guest_id => params[:guest_id], :importance => params[:importance]}
            #Importance.create @importance
                render xml: @guest
        else
            Guest.create params[:guest]
            redirect_to guests_path
        end

       # render json: @importance
        # redirect_to guests_path
    end

    # GET /guests/new
    def new
          @guest = Guest.new
          respond_to do |format|
            format.html #index.html.erb
            format.json { render json: @guest }
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
