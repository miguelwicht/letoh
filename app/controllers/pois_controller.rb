class PoisController < ApplicationController
    # GET /pois
    # GET /pois.json
    def index
        @poi = Poi.new
        @pois = Poi.all

        respond_to do |format|
            format.html #index.html.erb
            format.json { render json: @pois }
        end
    end

    # GET /pois/1
    # GET /pois/1.json
    def show
        @poi = Poi.find(params[:id])

        respond_to do |format|
            format.html #index.html.erb
            format.json { render json: @poi }
        end
    end

    def create
        #render :text => params.inspect
        Poi.create params[:poi]
        redirect_to pois_path
    end

    # GET /pois/new
    def new
          @poi = Poi.new
          respond_to do |format|
            format.html #index.html.erb
            format.json { render json: @pois }
        end
    end

    def edit
        @poi = Poi.find params[:id]
    end

    def update
        poi = Poi.find params[:id]
        if poi.update_attributes params[:poi]
            redirect_to pois_path, :notice => 'Your poi has successfully been updated.'
        else
            redirect_to :back, :notice => 'There was an error updating your poi.'
        end
    end

    def destroy
        Poi.destroy params[:id]
        redirect_to :back, :notice => 'Poi has been deleted.'
    end

    # GET /pois/guest/1
    # GET /pois/guest/1.json
    def guest
        #query all interests that have an importance for the guest
        @interests = Interest.includes(:importances).where(:importances => {:guest_id => params[:id]})#.includes(:importances)#.includes(:categorizations)#.includes(:interests)#.includes(:guests).where(:guests => {:id => params[:id]})

        #query the matching pois for each interest
        user_pois = []
        @interests.each_with_index do |interest, index|
            user_pois[index] = Categorization.where(:interest_id => interest.id)
        end

        @user_pois = user_pois
        @user_pois.to_json

        #rearrange the pois
        map_pois = []
        @user_pois.each_with_index do |cat, index|
            cat.each_with_index do |poi, i|
                map_pois.push(Poi.includes(:categorizations).where(:categorizations =>{:poi_id => poi.poi_id}))
            end
        end

        @map_pois = map_pois
        @map_pois.to_json


        #@user_pois = Importance.includes(:categorizations)
        @pois = Poi.all
        #@pois = Importance.where(:importances => {:guest_id => params})
        respond_to do |format|
            format.html #index.html.erb
            format.json { render json: @interests }
        end
    end
end
