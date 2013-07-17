require 'minitest/spec'
require 'minitest/autorun'
require 'test_helper'

describe StreakClient::Stage do

  before(:each) do
    @pipeline = StreakClient::Pipeline.create(name: "Test", description: "T")
    @stage = StreakClient::Stage.create(@pipeline.pipelineKey, {name: "Stage"})
  end

  after(:each) do
    StreakClient::Pipeline.delete(@pipeline.pipelineKey)
  end

  it "can create one" do
    @stage.key.wont_be_nil
  end

  it "can delete one" do
    StreakClient::Stage.delete(@pipeline.pipelineKey, @stage.key)
    StreakClient::Box.all.size.must_equal 0
  end

end
