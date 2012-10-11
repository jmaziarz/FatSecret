require 'spec_helper'

describe FatSecret::Connection do

  describe '.get' do
    it do
      FatSecret::Connection.should respond_to(:get)
    end
  end
end
