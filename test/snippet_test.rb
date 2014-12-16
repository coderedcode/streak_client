require 'minitest/spec'
require 'minitest/autorun'
require 'test_helper'

describe StreakClient::Snippet do

  it "can get all snippets" do
    snippets = StreakClient::Snippet.all
    snippets.wont_be_nil
  end

  it "can get a specific snippet" do
    # No test for this as there's currently no way to create a snippet
  end

end
