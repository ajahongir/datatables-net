require 'spec_helper'

describe DatatablesNet do
  describe "configurations" do
    context "configurable from outside" do
      before(:each) do
        DatatablesNet.configure do |config|
          config.db_adapter = :mysql
        end
      end

      it "should have custom value" do
        expect(DatatablesNet.config.db_adapter).to eq(:mysql)
      end
    end
  end
end

describe DatatablesNet::Configuration do
  let(:config) { DatatablesNet::Configuration.new }

  describe "default config" do
    it "default orm should :active_record" do
      expect(config.orm).to eq(:active_record)
    end

    it "default db_adapter should :pg (postgresql)" do
      expect(config.db_adapter).to eq(:pg)
    end
  end

  describe "custom config" do
    it 'should accept db_adapter custom value' do
      config.db_adapter = :mysql
      expect(config.db_adapter).to eq(:mysql)
    end

    it 'accepts a custom orm value' do
      config.orm = :mongoid
      expect(config.orm).to eq(:mongoid)
    end
  end
end
