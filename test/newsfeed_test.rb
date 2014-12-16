require 'minitest/spec'
require 'minitest/autorun'
require 'test_helper'

describe StreakClient::Newsfeed do

  before(:each) do
    @pipeline = StreakClient::Pipeline.create(name: "Test", description: "T")
    @stage = StreakClient::Stage.create(@pipeline.pipelineKey, {name: "Stage 1"})
    @box = StreakClient::Box.create(@pipeline.pipelineKey, {name: "Test Box"})
  end

  after(:each) do
    @pipeline.boxes.each {|box| StreakClient::Box.delete(box.boxKey) }
    StreakClient::Pipeline.delete(@pipeline.pipelineKey)
  end

  it "can retrieve a newsfeed" do
    @pipeline.newsfeed.events.first.wont_be_nil
  end

end

