require 'minitest/spec'
require 'minitest/autorun'
require 'test_helper'

describe StreakClient::Pipeline do

  before(:each) do
    StreakClient.api_key = "0b6359c686584bc3b610a640e2e7eb9f"

    @pipeline = StreakClient::Pipeline.create(name: "Test", description: "T")
  end

  after(:each) do
    StreakClient::Pipeline.delete(@pipeline.pipelineKey)
  end

  it "can create one" do
    @pipeline.pipelineKey.wont_be_nil
  end

  it "can find one" do
    found = StreakClient::Pipeline.find(@pipeline.pipelineKey)
    found.name.must_equal "Test"
  end

  it "can find all" do
    all = StreakClient::Pipeline.all
    all.size.must_be :>, 0
  end

  it "can add and list boxes" do
    @pipeline.add_box(name: "Box")
    @pipeline.boxes.first.name.must_equal "Box"
  end

  it "can add and list stages" do
    @pipeline.add_stage(name: "Stage 1")
    @pipeline.stages.first.name.must_equal "Stage 1"
  end

end

