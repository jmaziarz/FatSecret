require 'spec_helper'

describe FatSecret::Base do

  it { should have_attribute(:id).of_type(Integer) }
end
