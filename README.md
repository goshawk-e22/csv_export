# CsvExport

Painless csv export in Ruby on Rails

## Installation

Add this line to your application's Gemfile:

    gem 'csv_export'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install csv_export

## Usage

  That gem provide export_to_csv(filename, content, [options = {}]) method in your controller.

  *filename* - String, which define output file's name. NOTE: method doesn't add `.csv` extention automaticly
  *content* - Items' enumerable. By default expected that item is some kind of array. If item responds to `to_csv_row`, gem will use it. Also if item isn't array and doesn't have `to_csv_row` it will wrap item in to the array
  *options* - Optional argument. Expects it will be some kind of hash. Processed keys:
    :separator - sets custom separator(by default is ",")
    :headers - sets header row. Expected array with columns' names

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
