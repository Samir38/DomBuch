class RecordDecorator

  attr_reader :params

  def initialize(records)
    @records = records.order(date: :desc)
  end

  def filtered(params)
    @params = params
    filter_date
    filter_page
  end

  private

  def filter_page
    per_page = params[:per_page]
    page = params[:page]
    @records = @records.paginate(:page => page ? page : 1, :per_page => per_page ? per_page : 10)
  end

  def filter_date
    @records = @records.where('date >= ? AND date <= ?', get_timestamp(params[:start]), get_timestamp(params[:end]))
  end

  def get_timestamp(date)
    Date.strptime(date, '%d/%m/%Y')
  end

end