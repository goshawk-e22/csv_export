module CsvExport
  if RUBY_VERSION =~ /1.8/
    require 'fastercsv'
    CSV = FasterCSV
  else
    require 'csv'
  end

  module Base

    private

    def export_to_csv(filename, content, options = {})
      csv_options = {}
      csv_options[:col_sep] = options[:separator] || ','
      headers = options[:headers]
      csv_options[:headers] = headers.present?

      data = CSV.generate(csv_options) do |csv_data|
        csv_data << headers if csv_options[:headers]

        content.each do |item|
          case
          when item.respond_to?(:to_csv_row)
            csv_data << item.to_csv_row
          when item.respond_to?(:to_a)
            csv_data << item.to_a
          else
            csv_data << [item]
          end
        end
      end

      send_data(data, :filename => filename,:type => 'text/csv')
    end

  end

end
