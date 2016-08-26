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

    context 'when there are no results', :no_results do
      subject do
        VCR.use_cassette('search_for_non_existant_food', match_requests_on: [ :host ], allow_playback_repeats: true) do
          FatSecret::Food.search('asdf')
        end
      end

      it 'should have a result count of zero' do
        subject.total_results.should eql(0)
      end

      it 'should have no foods' do
        subject.should be_empty
      end

      it 'should be an array' do
        subject.should be_a(Array)
      end
    end

    context 'when there is only one result' do
      VCR.use_cassette('search_for_milk', match_requests_on: [ :host ], allow_playback_repeats: true) do
        FatSecret::Food.search('Milk', page_number: 0, max_results: 1)
      end

      it 'should have one result' do
        subject.count.should eq(1)
      end
    end
  end

  describe '.get' do
    before { configure }

    context 'when there are multiple servings', :multiple_servings do
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

    context 'when there is only 1 serving', :one_serving do
      subject do
        VCR.use_cassette(
          'get_steel_cut_oats', match_requests_on: [ :host ],
          allow_playback_repeats: true
        ) do
          FatSecret::Food.get(2095870)
        end
      end

      it { should be_instance_of(FatSecret::Food) }

      it { subject.servings.count.should eql(1) }

      it { subject.servings.first.calories.should eql(150.0) }
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
