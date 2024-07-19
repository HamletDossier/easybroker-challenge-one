require 'minitest/autorun'
require 'minitest/mock'
require_relative '../../services/easybroker_service'
require_relative '../../clients/easybroker_client'
require_relative '../../utils/errors'

describe EasyBrokerService do
    before do
      @service = EasyBrokerService.new
      @client_mock = Minitest::Mock.new
      @service.instance_variable_set(:@client, @client_mock)
    end
  
    describe 'EasyBroker service test suite' do
      it 'should get titles successfully' do
        mock_response = Minitest::Mock.new
        mock_response.expect :code, 200
        mock_response.expect :[], [{'title' => 'Property 1'}, {'title' => 'Property 2'}], ['content']
  
        @client_mock.expect :get_properties, mock_response, [1, 10]
  
        titles = @service.get_titles_from_properties(1, 10)
        _(titles).must_equal ['Property 1', 'Property 2']
  
        @client_mock.verify
        mock_response.verify
      end
  
      it 'should raise an error when page number be greater than 0' do
        _(proc { @service.get_titles_from_properties(0, 10) }).must_raise InvalidPageError
      end
  
      it 'should raise an error when Limit must be greater then 0 and less then 51' do
        _(proc { @service.get_titles_from_properties(1, 0) }).must_raise InvalidLimitError
        _(proc { @service.get_titles_from_properties(1, 51) }).must_raise InvalidLimitError
      end
  
      it 'should raise an error when there is a connection Error' do
        mock_response = Minitest::Mock.new
        mock_response.expect :code, 500
        mock_response.expect :body, 'Internal Server Error'
  
        @client_mock.expect :get_properties, mock_response, [1, 10]
  
        _(proc { @service.get_titles_from_properties(1, 10) }).must_raise ConnectionError
  
        @client_mock.verify
        mock_response.verify
      end
  
      it 'should get an empty array when response is empty' do
        mock_response = Minitest::Mock.new
        mock_response.expect :code, 200
        mock_response.expect :[], [], ['content']
  
        @client_mock.expect :get_properties, mock_response, [1, 10]
  
        titles = @service.get_titles_from_properties(1, 10)
        _(titles).must_equal []
  
        @client_mock.verify
        mock_response.verify
      end
    end
  end