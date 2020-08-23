# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Url, type: :model do
  describe 'validations' do
    it 'validates original URL is a valid URL' do
      # skip 'add test'
      new_url = Url.new(original_url:"something")
      expect(new_url).to_not be_valid
      new_url = Url.new(original_url:"http://fb.com",short_url:Url.generate_short_url)
      expect(new_url).to be_valid  
    end
  end
end
