require 'spec_helper'

describe Connectator::Pinger do
  
  Then { Connectator::Pinger.ping?('localhost').should be_true }
  Then { Connectator::Pinger.ping?('iamnotahostname').should be_false }

  describe "worse than the allowable timeout" do
    Given { Connectator::Pinger.stub(:system_ping_command).and_return("sleep 1") }
    Then { Connectator::Pinger.ping?('localhost').should be_false }
  end
  
  describe "better than the allowable timeout" do
    Given { Connectator::Pinger.stub(:system_ping_command).and_return("sleep 1") }
    Then { Connectator::Pinger.ping?('localhost', 2).should be_true }
  end
end
