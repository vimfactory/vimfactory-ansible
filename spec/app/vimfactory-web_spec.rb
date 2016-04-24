require 'spec_helper'

describe file('/home/vimfactory/app/vimfactory-web') do
  it { should be_directory }
end

describe service('vimfactory-web') do 
  it { should be_enabled   }
  it { should be_running   }
end

describe file('/home/vimfactory/vimrcs/vimrc_default') do
  it { should exist }
end
