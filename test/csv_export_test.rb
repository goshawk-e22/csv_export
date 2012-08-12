if RUBY_VERSION =~ /1.8/
  require 'test/unit'
end

require 'minitest/autorun'
require 'minitest/mock'
require 'action_controller'
require 'action_dispatch'
require 'csv_export'

SharedTestRoutes = ActionDispatch::Routing::RouteSet.new
SharedTestRoutes.draw do
  get ':controller(/:action)'
end

class CsvExportTest < ActionController::TestCase
  include ActionDispatch::TestProcess

  class TestController < ActionController::Base
    include SharedTestRoutes.url_helpers
    include SharedTestRoutes.mounted_helpers

    def export_base
      content = 5.times.map { |i| 3.times.map { |j| i * j } }
      export_to_csv 'test.csv', content
    end

    def export_csv_rows
      content = 2.times.map do
        item = MiniTest::Mock.new
        item.expect :to_csv_row, [1, 2, 3]
        item
      end
      export_to_csv 'test.csv', content
    end

    def export_with_options
      content = [[ 1, 2, 3]]
      export_to_csv 'foo', content, :headers => ['One', 'Two', 'Three'], :separator => ";"
    end

    def export_slim_array
      content = [2, 3]
      export_to_csv 'slim', content
    end

  end

  tests TestController

  setup do
    @routes = SharedTestRoutes
  end

  def test_header_response
    get :export_base

    assert_equal 200, @response.status
    assert_equal 'text/csv', @response.content_type
    assert @response.headers['Content-Disposition'].include?('test.csv')
  end

  def test_base_content
    get :export_base

    assert_equal 5, @response.body.lines.count
    assert_equal "0,0,0\n", @response.body.lines.to_a[0]
    assert_equal "0,4,8\n", @response.body.lines.to_a[-1]
  end

  def test_using_csv_rows
    get :export_csv_rows

    assert_equal "1,2,3\n", @response.body.lines.to_a[0]
  end

  def test_using_options
    get :export_with_options

    assert_equal "One;Two;Three\n", @response.body.lines.to_a[0]
    assert_equal "1;2;3\n", @response.body.lines.to_a[1]
  end

  def test_slim_array_case
    get :export_slim_array

    assert_equal "2\n", @response.body.lines.to_a[0]
    assert_equal "3\n", @response.body.lines.to_a[1]
  end

end
