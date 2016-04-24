require 'spec_helper'

describe package('docker') do
  it { should be_installed }
end

describe service('docker') do 
  it { should be_enabled   }
  it { should be_running   }
end

describe docker_image('mosuke5/vimonly:latest') do
  it { should exist }
end
