require 'spec_helper'

describe user('vimfactory') do
  it { should exist }
end

describe group('vimfactory') do
  it { should exist }
end
