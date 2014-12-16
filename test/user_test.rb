require 'minitest/spec'
require 'minitest/autorun'
require 'test_helper'

describe StreakClient::User do

  it "can find me" do
    user = StreakClient::User.find_me
    user.email.wont_be_nil
  end

  it "can find me by user key" do
    user = StreakClient::User.find_me
    user_2 = StreakClient::User.find(user.key)
    user_2.email.must_equal user.email
  end

end
