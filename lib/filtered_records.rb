class FilteredRecords

  attr_reader :params, :records

  def initialize(relation = Record.scoped, params = {})
    @records = relation.order(date: :desc)
    @params = params
  end

  def collection
    filtered.records
  end

  def filtered
    categorized.filter_date.filter_page
  end

  def categorized
    return self if params[:category].nil?
    category_id = params[:category] == 'none' ? nil : Category.find_by(name: params[:category]).id
    FilteredRecords.new(records.where(category_id: category_id), params)
  end

  def filter_page
    per_page = params[:per_page] || 10
    page = params[:page] || 1
    FilteredRecords.new(records.paginate(:page => page, :per_page => per_page), params)
  end

  def filter_date
    start_date = begin
      get_timestamp(params[:start])
    rescue
      Time.now - 1000.years
    end
    end_date = begin
      get_timestamp(params[:end])
    rescue
      Time.now + 1000.years
    end
    FilteredRecords.new(records.where('date >= ? AND date <= ?', start_date, end_date), params)
  end

  def get_timestamp(date)
    Date.strptime(date, '%d/%m/%Y')
  end

end