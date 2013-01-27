class BookingsController < ApplicationController
    # GET /bookings
    # GET /bookings.json
    def index
        @booking = Booking.new
        @bookings = Booking.all

        respond_to do |format|
            format.html #index.html.erb
            format.json { render json: @bookings }
        end
    end
    # GET /bookings/1
    # GET /bookings/1.json
    def show
        @booking = Booking.find(params[:id])

        respond_to do |format|
            format.html #index.html.erb
            format.json { render json: @booking }
        end
    end

    def create
        #render :text => params.inspect
        Booking.create params[:booking]
        redirect_to bookings_path
    end

    # GET /guests/new
    def new
          @booking = Booking.new
    end

    def edit
        @booking = Booking.find params[:id]
    end

    def update
        booking = Booking.find params[:id]
        if guest.update_attributes params[:booking]
            redirect_to bookings_path, :notice => 'Your Booking has successfully been updated.'
        else
            redirect_to :back, :notice => 'There was an error updating your Booking.'
        end
    end

    def destroy
        Booking.destroy params[:id]
        redirect_to :back, :notice => 'Booking has been deleted.'
    end
end
