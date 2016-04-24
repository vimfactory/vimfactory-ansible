require 'spec_helper'

describe command('/usr/local/bin/ruby -v') do
  its(:stdout) { should contain('2.1.5p273') }
end
