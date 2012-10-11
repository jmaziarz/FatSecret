require 'spec_helper'

describe FatSecret do
  it { should respond_to(:configure) }

  describe '.configure' do
    before do
      FatSecret.configure do |f|
        f.access_key    = '1234'
        f.consumer_key  = 'abcd'
        f.shared_secret = 'I see dead people'
        f.logger        = logger
      end
    end

    let(:logger) { Logger.new($STDOUT) }

    subject { FatSecret.configuration }

    it 'should initialize a new config object' do
      FatSecret.configuration.should be_a(FatSecret::Config)
    end

    it 'should set the access key' do
      subject.access_key.should eql('1234')
    end

    it 'should set the consumer key' do
      subject.consumer_key.should eql('abcd')
    end

    it 'should set the shared secret' do
      subject.shared_secret.should eql('I see dead people')
    end

    it 'should set the logger' do
      subject.logger.should eql(logger)
    end
  end
end
