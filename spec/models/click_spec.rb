# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Click, type: :model do
  describe 'validations' do
    it 'validates url_id is valid' do
      # skip 'add test'
      new_click = Click.new(url_id:122222)
      expect(new_click).to_not be_valid
      new_url = Url.create(original_url:"http://fb.com",short_url:Url.generate_short_url)
      new_click = Click.create(browser:"Chrome",platform:"generic",url_id:new_url.id)
      expect(new_click).to be_valid  
    end

    it 'validates browser is not null' do
      # skip 'add test'
      new_url = Url.create(original_url:"http://fb.com",short_url:Url.generate_short_url)
      new_click = Click.create(platform:"generic",url_id:new_url.id)
      expect(new_click).to_not be_valid
      new_click = Click.create(browser:"Chrome",platform:"generic",url_id:new_url.id)
      expect(new_click).to be_valid
    end

    it 'validates platform is not null' do
      # skip 'add test'
      new_url = Url.create(original_url:"http://fb.com",short_url:Url.generate_short_url)
      new_click = Click.create(browser:"chrome",url_id:new_url.id)
      expect(new_click).to_not be_valid
      new_click = Click.create(browser:"Chrome",platform:"generic",url_id:new_url.id)
      expect(new_click).to be_valid
    end
  end
end
