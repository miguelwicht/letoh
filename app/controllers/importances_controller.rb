class ImportancesController < ApplicationController
    protect_from_forgery :except => :create

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
        #logger.debug params.inspect
        #Importance.create params[:importance]

        # Data send from Flash are not nested in :importance object so this has to be handled differently
        if (params[:interest_id] && params[:guest_id] && params[:importance])

            Importance.find_or_initialize_by_guest_id_and_interest_id(
                 params[:guest_id], params[:interest_id]
                 ).tap do |a|
                    if (a.importance.to_i > 0)
                        a.importance = (a.importance.to_i + params[:importance].to_i) / 2
                    else
                        a.importance = params[:importance].to_i
                    end
                    @importance = a
                end.save!

            #@importance = {:interest_id => params[:interest_id], :guest_id => params[:guest_id], :importance => params[:importance]}
            #Importance.create @importance
                render json: @importance
        else
            Importance.create params[:importance]
            redirect_to importances_path
        end
    end

    # GET /importances/new
    def new
        @importance = Importance.new
        respond_to do |format|
            format.html #index.html.erb
            format.json { render json: @importance }
        end
    end

    def edit
        @importance= Importance.find params[:id]
    end

    def update
        importance= Importance.find params[:id]
        if importance.update_attributes params[:importance]
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
