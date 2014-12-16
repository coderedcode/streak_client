require 'minitest/spec'
require 'minitest/autorun'
require 'test_helper'

describe StreakClient::Thread do

  before(:each) do
    @pipeline = StreakClient::Pipeline.create(name: "Test", description: "T")
    @stage = StreakClient::Stage.create(@pipeline.pipelineKey, {name: "Stage 1"})
    @box = StreakClient::Box.create(@pipeline.pipelineKey, {name: "Test Box"})
  end

  after(:each) do
    @pipeline.boxes.each {|box| StreakClient::Box.delete(box.boxKey) }
    StreakClient::Pipeline.delete(@pipeline.pipelineKey)
  end

  it "can get threads for a box" do
    @box.threads.wont_be_nil
  end

  it "can get a specific thread" do
    # Currently no way to test this since you can't create a thread via API
  end

end
