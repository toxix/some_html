require 'test_helper'

class CoreExtTest < Test::Unit::TestCase
  def test_to_SomeHtml_shold_exist
      assert_equal "Hello World", "Hello World".some_html
  end
end
