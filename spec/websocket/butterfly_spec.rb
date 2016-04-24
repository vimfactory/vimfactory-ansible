require 'spec_helper'

describe service('butterfly') do 
  it { should be_enabled   }
  it { should be_running   }
end
