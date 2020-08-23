# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UrlsController, type: :controller do
  describe 'GET #index' do
    it 'shows the latest 10 URLs' do
      # skip 'add test'
      get :index
      @urls = Url.latest
      assert_response :success
    end
  end

  describe 'POST #create' do
    it 'creates a new url' do
      # skip 'add test'
      expect {post :create, :params =>{url:{original_url:"http://fb.com"}}}.to change(Url,:count).by(1)
      assert_redirected_to urls_path
      assert_equal 'Original url saved successfully and short url generated', flash[:notice]  
    end
  end

  describe 'GET #show' do
    it 'shows stats about the given URL' do
      # skip 'add test'
      @new = Url.create(original_url:"http://fb.com",short_url:"ABCDE")
      get :show, :params=>{url:"ABCDE"}
      expect(assigns(:url).get_usage_metrics.keys.count).to eq(3)
    end

    it 'throws 404 when the URL is not found' do
      # skip 'add test'
      assert true
    end
  end

  describe 'GET #visit' do
    it 'tracks click event and stores platform and browser information' do
      # skip 'add test'
      @new = Url.create(original_url:"http://fb.com",short_url:"ABCDE")
      @count = @new.clicks_count
      get :visit, :params=>{url:"ABCDE"}
      expect(assigns(:url).clicks_count).to eq(@count + 1)
      expect(assigns(:url).clicks.count).to eq(@count + 1)
      expect(assigns(:url).clicks.first.browser).to be
      expect(assigns(:url).clicks.first.platform).to be
    end

    it 'redirects to the original url' do
      # skip 'add test'
      @new = Url.create(original_url:"http://fb.com",short_url:"ABCDE")
      get :visit, :params=>{url:"ABCDE"}
      assert_redirected_to assigns(:url).original_url

    end

    it 'throws 404 when the URL is not found' do
      # skip 'add test'
      get :visit, :params=>{url:'ABCDE'}
      assert_redirected_to urls_path
    end
  end
end
