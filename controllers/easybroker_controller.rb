require_relative '../services/easybroker_service'

class EasybrokerController
    def initialize
        @service = EasyBrokerService.new
    end

    def get_titles_from_properties(page, limit)
        return @service.get_titles_from_properties(page,limit)
    end
end