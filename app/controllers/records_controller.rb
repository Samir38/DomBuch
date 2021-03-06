class RecordsController < ApplicationController
  before_action :set_record, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @records = FilteredRecords.new(current_user.records, params).collection
    @categories = current_user.not_empty_categories
    @sum = Record.user_summary(current_user)
  end

  def show
  end

  # GET /records/new
  def new
    @record = current_user.records.new
  end

  # GET /records/1/edit
  def edit
  end

  # POST /records
  # POST /records.json
  def create
    @record = current_user.records.new(record_params)
    category = params[:category] ? current_user.categories.find_or_create_by(name: params[:category]) : nil
    @record.category = category if category
    respond_to do |format|
      if @record.save
        format.html { redirect_to @record, notice: 'Запись успешно создана.' }
        format.json { render action: 'show', status: :created, location: @record }
      else
        format.html { render action: 'new' }
        format.json { render json: @record.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    category = params[:category] ? current_user.categories.find_or_create_by(name: params[:category]) : nil
    @record.category = category if category
    respond_to do |format|
      if @record.update(record_params)
        format.html { redirect_to @record, notice: 'Запись успешно обновлена.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /records/1
  # DELETE /records/1.json
  def destroy
    @record.destroy
    respond_to do |format|
      format.html { redirect_to records_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_record
    @record = current_user.records.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def record_params
    params.require(:record).permit(:desc, :sum, :date, :kind)
  end
end
