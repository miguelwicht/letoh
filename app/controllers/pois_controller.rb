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
        #get sum of all importances
        @sum = Importance.where(:guest_id => params[:id]).sum('importance')

        #query all interests that have an importance for the guest
        @interests = Interest.includes(:importances).where(:importances => {:guest_id => params[:id]})

        #query the matching pois for each interest
        #categories
        user_pois = []
        @interests.each_with_index do |interest, index|
            user_pois[index] = []
            user_pois[index].push(Categorization.where(:interest_id => interest.id))
            user_pois[index].push( ((Importance.where(:guest_id => params[:id]).where(:interest_id => interest.id).sum('importance').to_f / @sum) * 8).round )
        end

        #rearrange the pois
        map_pois = []
        user_pois.each_with_index do |cat, index|
            cat[1].times do |i|
                if cat[0].count > i
                    map_pois.push(Poi.includes(:categorizations).where(:categorizations =>{:poi_id => cat[0][i-1].poi_id}))
                end
            end
        end

        @map_pois = map_pois.flatten(1).to_a.uniq.to_json

        respond_to do |format|
            format.html #index.html.erb
            format.json { render json: @map_pois }
        end


        #-----------------------------------------------------------------------
        # #query all interests that have an importance for the guest
        # @interests = Interest.includes(:importances).where(:importances => {:guest_id => params[:id]})

        # #query the matching pois for each interest
        # user_pois = []
        # @interests.each_with_index do |interest, index|
        #     user_pois[index] = Categorization.where(:interest_id => interest.id)
        # end

        # #rearrange the pois
        # map_pois = []
        # user_pois.each_with_index do |cat, index|
        #     cat.each_with_index do |poi, i|
        #         map_pois.push(Poi.includes(:categorizations).where(:categorizations =>{:poi_id => poi.poi_id}))
        #     end
        # end

        # @map_pois = map_pois.flatten(1).to_a.uniq.to_json

        # respond_to do |format|
        #     format.html #index.html.erb
        #     format.json { render json: @map_pois }
        # end
    end
end
