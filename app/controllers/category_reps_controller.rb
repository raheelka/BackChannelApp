class CategoryRepsController < ApplicationController
  before_action :set_category_rep, only: [:show, :edit, :update, :destroy]

  # GET /category_reps
  # GET /category_reps.json
  def index
    if current_user==admin_user
    @category_reps = CategoryRep.all
    else
      redirect_to root_path
    end

  end

  # GET /category_reps/1
  # GET /category_reps/1.json
  def show
  end

  # GET /category_reps/new
  def new
    if current_user==admin_user
    @category_rep = CategoryRep.new
    else
      redirect_to root_path
      end
  end

  # GET /category_reps/1/edit
  def edit
    if current_user != admin_user
    redirect_to root_path
    end

  end

  # POST /category_reps
  # POST /category_reps.json
  def create
    @category_rep = CategoryRep.new(category_rep_params)

    respond_to do |format|
      if @category_rep.save
        format.html { redirect_to @category_rep, notice: 'Category rep was successfully created.' }
        format.json { render action: 'show', status: :created, location: @category_rep }
      else
        format.html { render action: 'new' }
        format.json { render json: @category_rep.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /category_reps/1
  # PATCH/PUT /category_reps/1.json
  def update
    respond_to do |format|
      if @category_rep.update(category_rep_params)
        format.html { redirect_to @category_rep, notice: 'Category rep was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @category_rep.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /category_reps/1
  # DELETE /category_reps/1.json
  def destroy
    @category_rep.destroy
    respond_to do |format|
      format.html { redirect_to category_reps_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category_rep
      @category_rep = CategoryRep.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_rep_params
      params.require(:category_rep).permit(:category)
    end
end
