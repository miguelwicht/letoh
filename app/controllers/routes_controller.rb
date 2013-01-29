class RoutesController < ApplicationController
    # GET /routes
    # GET /routes.json
    def index
        @route = Route.new
        @routes = Route.all

        respond_to do |format|
            format.html #index.html.erb
            format.json { render json: @routes }
        end
    end

    # GET /routes/1
    # GET /routes/1.json
    def show
        @route = Route.find(params[:id])

        respond_to do |format|
            format.html #index.html.erb
            format.json { render json: @route }
        end
    end

    def create
        #render :text => params.inspect
        Route.create params[:route]
        redirect_to routes_path
    end

    # GET /routes/new
    def new
          @route = Route.new
          respond_to do |format|
            format.html #index.html.erb
            format.json { render json: @routes }
        end
    end

    def edit
        @route = Route.find params[:id]
    end

    def update
        route = Route.find params[:id]
        if route.update_attributes params[:route]
            redirect_to routes_path, :notice => 'Your route has successfully been updated.'
        else
            redirect_to :back, :notice => 'There was an error updating your route.'
        end
    end

    def destroy
        Route.destroy params[:id]
        redirect_to :back, :notice => 'Route has been deleted.'
    end
end
