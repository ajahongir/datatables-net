require 'spec_helper'

describe DatatablesNet::Base do
  describe 'an instance' do
    let(:view) { double('view', params: sample_params) }

    it 'requires a view_context' do
      expect { DatatablesNet::Base.new }.to raise_error ArgumentError
    end

    it 'accepts an options hash' do
      datatable = DatatablesNet::Base.new(view, foo: 'bar')
      expect(datatable.options).to eq(foo: 'bar')
    end
  end

  context 'Public API' do
    let(:view) { double('view', params: sample_params) }
    let(:datatable) { DatatablesNet::Base.new(view) }

    describe '#view_columns' do
      it 'raises an error if not defined by the user' do
        expect { datatable.view_columns }.to raise_error DatatablesNet::NotImplemented
      end

      context 'child class implements view_columns' do
        it 'expects an array based defining columns' do
          datatable = SampleDatatable.new(view)
          expect(datatable.view_columns).to be_a(Array)
        end

        it 'expects a hash based defining columns' do
          datatable = ComplexDatatable.new(view)
          expect(datatable.view_columns).to be_a(Hash)
        end
      end
    end

    describe '#data' do
      it 'raises an error if not defined by the user' do
        expect { datatable.data }.to raise_error DatatablesNet::NotImplemented
      end

      context 'child class implements data' do
        let(:datatable) { ComplexDatatable.new(view) }

        it 'can return an array of hashes' do
          allow(datatable).to receive(:data) { [{}, {}] }
          expect(datatable.data).to be_a(Array)
          item = datatable.data.first
          expect(item).to be_a(Hash)
        end

        it 'can return an array of arrays' do
          allow(datatable).to receive(:data) { [[], []] }
          expect(datatable.data).to be_a(Array)
          item = datatable.data.first
          expect(item).to be_a(Array)
        end
      end

    end

    describe '#get_raw_records' do
      it 'raises an error if not defined by the user' do
        expect { datatable.get_raw_records }.to raise_error DatatablesNet::NotImplemented
      end
    end
  end

  context 'Private API' do
    let(:view) { double('view', params: sample_params) }
    let(:datatable) { ComplexDatatable.new(view) }

    before(:each) do
      allow_any_instance_of(DatatablesNet::Configuration).to receive(:orm) { nil }
    end

    describe 'fetch records' do
      it 'raises an error if it does not include an ORM module' do
        expect { datatable.send(:fetch_records) }.to raise_error
      end
    end

    describe 'filter records' do
      it 'raises an error if it does not include an ORM module' do
        expect { datatable.send(:filter_records) }.to raise_error
      end
    end

    describe 'sort records' do
      it 'raises an error if it does not include an ORM module' do
        expect { datatable.send(:sort_records) }.to raise_error
      end
    end

    describe 'paginate records' do
      it 'raises an error if it does not include an ORM module' do
        expect { datatable.send(:paginate_records) }.to raise_error
      end
    end

    describe 'helper methods' do
      describe '#offset' do
        it 'defaults to 0' do
          default_view = double('view', params: {})
          datatable = DatatablesNet::Base.new(default_view)
          expect(datatable.datatable.send(:offset)).to eq(0)
        end

        it 'matches the value on view params[:start] minus 1' do
          paginated_view = double('view', params: { start: '11' })
          datatable = DatatablesNet::Base.new(paginated_view)
          expect(datatable.datatable.send(:offset)).to eq(10)
        end
      end

      describe '#page' do
        it 'calculates page number from params[:start] and #per_page' do
          paginated_view = double('view', params: { start: '11' })
          datatable = DatatablesNet::Base.new(paginated_view)
          expect(datatable.datatable.send(:page)).to eq(2)
        end
      end

      describe '#per_page' do
        it 'defaults to 10' do
          datatable = DatatablesNet::Base.new(view)
          expect(datatable.datatable.send(:per_page)).to eq(10)
        end

        it 'matches the value on view params[:length]' do
          other_view = double('view', params: { length: 20 })
          datatable = DatatablesNet::Base.new(other_view)
          expect(datatable.datatable.send(:per_page)).to eq(20)
        end
      end
    end
  end
end
