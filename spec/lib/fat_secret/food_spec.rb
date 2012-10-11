require 'spec_helper'

describe FatSecret::Food do

  describe '.search' do
    before { configure }

    subject do
      VCR.use_cassette('search_for_milk', match_requests_on: [ :host ], allow_playback_repeats: true) do
        FatSecret::Food.search('Milk')
      end
    end

    it 'should get search results' do
      subject.should_not be_blank
    end

    it 'should contain food objects' do
      subject.first.class.should eql(FatSecret::Food)
    end

    it 'should be an array' do
      subject.should be_a(Array)
    end

    it 'should store the total results count' do
      subject.total_results.should eql(1125)
    end

    it 'should have a page number' do
      subject.page_number.should eq(0)
    end
  end

  describe '.get' do
    before { configure }

    subject do
      VCR.use_cassette('get_milk', match_requests_on: [ :host ], allow_playback_repeats: true) do
        FatSecret::Food.get(793)
      end
    end

    it 'should return a food object' do
      subject.should be_instance_of(FatSecret::Food)
    end

    it 'should populate the food name' do
      subject.name.should eql('Milk')
    end

    it 'should populate the servings' do
      subject.servings.should_not be_blank
    end

    it 'should use serving objects in the servings relation' do
      subject.servings.first.should be_instance_of(FatSecret::Serving)
    end

    it 'should add the serving data to the servings' do
      subject.servings.first.saturated_fat.should eql(2.965)
    end
  end

  describe '#servings' do
    before { configure }

    let(:foods) do
      VCR.use_cassette('search_for_milk', match_requests_on: [ :host ], allow_playback_repeats: true) do
        FatSecret::Food.search('Milk')
      end
    end

    subject do
      VCR.use_cassette('get_servings_association', match_requests_on: [ :host ], allow_playback_repeats: true) do
        servings = foods.first.servings
      end
    end

    it 'should load the servings' do
      subject.should_not be_blank
    end
  end
end
