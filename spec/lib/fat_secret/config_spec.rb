require 'spec_helper'

describe FatSecret::Config do

  subject { FatSecret::Config.new }

  it 'should have a default logger' do
    subject.logger.class.should == Logger
  end

  it 'should have the default rest api uri' do
    subject.uri.should eql('http://platform.fatsecret.com/rest/server.api')
  end

  it { should respond_to(:access_key) }

  it { should respond_to(:consumer_key) }

  it { should respond_to(:shared_secret) }
end
