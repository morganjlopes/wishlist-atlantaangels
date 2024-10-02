module ApplicationHelper
  include Pagy::Frontend

  def icon(name, custom_classes = '')
    default_class = {
      'search' => "fa fa-solid fa-magnifying-glass",
      'users' => "fa fa-solid fa-users",
    }[name]

    raw "<i class='#{default_class} #{custom_classes}'></i>"
  end

  def no_records_html
    content = "No records found."
    content += " " + link_to('Clear parameters', url_for(), class: 'text-danger') if params[:q] || params[:scope]

    raw "<div class='text-center text-muted p-3'>#{content}</div>"
  end

  def format_currency(amount, precision = 2)
    number_to_currency(amount, precision: precision)
  end

  def format_percentage(amount)
    number_to_percentage(amount, precision: 0)
  end

  def format_date(datetime)
    datetime&.strftime('%b %d, %Y')
  end

  def format_date_with_day(datetime)
    datetime&.strftime('%A, %b %d')
  end

  def format_datetime(datetime)
    datetime&.strftime('%b %d, %Y - %l:%M %p').gsub(/:00 /, ' ')
  end

  def format_time(datetime)
    datetime&.strftime('%l:%M %p')
  end

  def format_day(datetime)
    datetime&.strftime('%a')
  end

  def format_date_no_year(datetime)
    datetime&.strftime('%b %d')
  end

  def format_date_range(start_date, end_date)
    if start_date.present? && end_date.present? && (start_date.to_date != end_date.to_date)
      "#{format_date(start_date)} - #{format_date(end_date)}"
    elsif start_date.present?
      "#{format_date(start_date)}"
    elsif end_date.present?
      "#{format_date(end_date)}"
    end
  end

  def format_duration(start_date, end_date)
    "#{distance_of_time_in_words(start_date, end_date)}"
  end
end
