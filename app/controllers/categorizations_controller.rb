class CategorizationsController < ApplicationController
    # GET /categorizations
    # GET /categorizations.json
    def index
        @categorization = Categorization.new
        @categorizations = Categorization.all

        respond_to do |format|
            format.html #index.html.erb
            format.json { render json: @categorizations }
        end
    end

    # GET /categorizations/1
    # GET /categorizations/1.json
    def show
        @categorization = Categorization.find(params[:id])

        respond_to do |format|
            format.html #index.html.erb
            format.json { render json: @categorization }
        end
    end

    def create
        #render :text => params.inspect
        Categorization.create params[:categorization]
        redirect_to categorizations_path
    end

    # GET /categorizations/new
    def new
          @categorization = Categorization.new
          respond_to do |format|
            format.html #index.html.erb
            format.json { render json: @categorizations }
        end
    end

    def edit
        @categorization= Categorization.find params[:id]
    end

    def update
        categorization= Categorization.find params[:id]
        if categorization.update_attributes params[:categorization]
            redirect_to categorizations_path, :notice => 'Your categorization has successfully been updated.'
        else
            redirect_to :back, :notice => 'There was an error updating your categorization.'
        end
    end

    def destroy
        Categorization.destroy params[:id]
        redirect_to :back, :notice => 'Categorization has been deleted.'
    end
end
