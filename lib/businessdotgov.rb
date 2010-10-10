require 'rubygems'
require 'weary'

module BusinessDotGov
  class LoansGrants
    attr_accessor :state_abbreviation, :industry, :data_format
    
    API_URL = 'http://api.business.gov/loans_grants/STATE ABBREVIATION/for_profit/INDUSTRY/nil.FORMAT'
    US_STATES = {      
      'ALABAMA' => 'AL',
      'ALASKA' => 'AK',
      'AMERICAN SAMOA' => 'AS',
      'ARIZONA' => 'AZ',
      'ARKANSAS' => 'AR',
      'CALIFORNIA' => 'CA',
      'COLORADO' => 'CO',
      'CONNECTICUT' => 'CT',
      'DELAWARE' => 'DE',
      'DISTRICT' => 'OF',
      'COLUMBIA' => 'DC',
      'FEDERATED STATES' => 'OF',
      'MICRONESIA' => 'FM',
      'FLORIDA' => 'FL',
      'GEORGIA' => 'GA',
      'GUAM' => 'GU',
      'HAWAII' => 'HI',
      'IDAHO' => 'ID',
      'ILLINOIS' => 'IL',
      'INDIANA' => 'IN',
      'IOWA' => 'IA',
      'KANSAS' => 'KS',
      'KENTUCKY' => 'KY',
      'LOUISIANA' => 'LA',
      'MAINE' => 'ME',
      'MARSHALL ISLANDS' => 'MH',
      'MARYLAND' => 'MD',
      'MASSACHUSETTS' => 'MA',
      'MICHIGAN' => 'MI',
      'MINNESOTA' => 'MN',
      'MISSISSIPPI' => 'MS',
      'MISSOURI' => 'MO',
      'MONTANA' => 'MT',
      'NEBRASKA' => 'NE',
      'NEVADA' => 'NV',
      'NEW HAMPSHIRE' => 'NH',
      'NEW JERSEY' => 'NJ',
      'NEW MEXICO' => 'NM',
      'NEW YORK' => 'NY',
      'NORTH CAROLINA' => 'NC',
      'NORTH DAKOTA' => 'ND',
      'NORTHERN MARIANA ISLANDS' => 'MP',
      'OHIO' => 'OH',
      'OKLAHOMA' => 'OK',
      'OREGON' => 'OR',
      'PALAU' => 'PW',
      'PENNSYLVANIA' => 'PA',
      'PUERTO RICO' => 'PR',
      'RHODE ISLAND' => 'RI',
      'SOUTH CAROLINA' => 'SC',
      'SOUTH DAKOTA' => 'SD',
      'TENNESSEE' => 'TN',
      'TEXAS' => 'TX',
      'UTAH' => 'UT',
      'VERMONT' => 'VT',
      'VIRGIN ISLANDS' => 'VI',
      'VIRGINIA' => 'VA',
      'WASHINGTON' => 'WA',
      'WEST VIRGINIA' => 'WV',
      'WISCONSIN' => 'WI',
      'WYOMING' => 'WY'
    }
    MILITARY_STATES = {
      'Armed Forces Africa' => 'AE',
      'Armed Forces Americas (except Canada)' => 'AA',
      'Armed Forces Canada' => 'AE',
      'Armed Forces Europe' => 'AE',
      'Armed Forces Middle East' => 'AE',
      'Armed Forces Pacific' => 'AP'
    }
    STATES = US_STATES # MILITARY_STATES
    
    INDUSTRIES = [
      'Agriculture', 
      'Child Care', 
      'Environmental Management',
      'Health Care',
      'Manufacturing',
      'Technology',
      'Tourism'
    ]
    
    DATA_FORMATS = [:xml, :json]
    
    def initialize
      @format = :json
    end
    
    def search(options = {})
      @industry = options[:industry]
      @state_abbreviation = options[:state_abbreviation]
      @format = options[:format] if options[:format]
      if @industry.nil?
        raise "Oops, an industry wasn't provided.  Please provide one of the following industries: #{INDUSTRIES.join(', ')}"
      end
      if @state_abbreviation.nil?
        raise "Oops, an US state wasn't provided.  Please provide one of the following US states: #{STATES.values.join(', ')}"
      end
      api_call = URI.escape(API_URL.sub(/STATE ABBREVIATION/, @state_abbreviation).sub(/INDUSTRY/, @industry).sub(/FORMAT/, @format.to_s))
      puts "api_call = #{api_call}"
      response = Weary.get(api_call).perform
      if response.success?
        return response.parse
      else
        raise "Something went wrong. Request failed with #{response.code}: #{response.message}"
      end
    end
  end
end


