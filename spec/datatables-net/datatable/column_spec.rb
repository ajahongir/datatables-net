require 'spec_helper'

describe 'DatatablesNet::Datatable::Column' do
  let(:view) { double('view', params: sample_params) }
  let(:datatable) { ComplexDatatable.new(view) }
  before {
    datatable.params[:columns] = {"0"=>{"data"=>"username", "name"=>"", "searchable"=>"true", "orderable"=>"true", "search"=>{"value"=>"searchvalue", "regex"=>"false"}}}
  }

  describe 'helper methods' do
    describe 'order methods' do
      let(:column) { datatable.datatable.columns.first }

      it 'should be orderable' do
        expect(column.orderable?).to eq(true)
      end

      it 'should be searchable' do
        expect(column.searchable?).to eq(true)
      end

      it 'should have connected to id column' do
        expect(column.data).to eq('username')
      end

      context '#search' do
        it 'child class' do
          expect(column.search).to be_a(DatatablesNet::Datatable::SimpleSearch)
        end

        it 'should have search value' do
          expect(column.search.value).to eq('searchvalue')
        end

        it 'should not regex' do
          expect(column.search.regexp?).to eq false
        end
      end

      describe '#cond' do
        it 'should be :like by default' do
          expect(column.cond).to eq(:like)
        end
      end

      describe '#source' do
        it 'should be :like by default' do
          expect(column.source).to eq('User.username')
        end
      end

      describe '#search_query' do
        it 'should buld search query' do
          expect(column.search_query.to_sql).to include('%searchvalue%')
        end
      end

      describe '#sort_query' do
        it 'should build sort query' do
          expect(column.sort_query).to eq('users.username')
        end
      end
    end
  end
end
