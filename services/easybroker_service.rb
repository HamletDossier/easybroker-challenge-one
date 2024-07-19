require_relative '../clients/easybroker_client'
require_relative '../utils/errors'

class EasyBrokerService
    def initialize
        @client = EasybrokerClient.new
        @limit_max = 51
    end

    def get_titles_from_properties(page,limit)
        raise InvalidPageError, "Page number be greater then 0" unless page > 0

        raise InvalidLimitError, "Limit must be greater then 0 and less then #{@limit_max}" unless limit > 0 && limit < @limit_max

        response = @client.get_properties(page, limit)
        
        raise ConnectionError, "Connection Error: #{response.body}" unless response.code == 200

        properties = response['content']

        if properties.empty?
            return []
        end

        titles = Array.new

        properties.each do |property|
            titles.push(property['title'])
        end

        return titles
    end
end
