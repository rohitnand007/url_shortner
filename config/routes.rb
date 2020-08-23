# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'urls#index'

  resources :urls, only: %i[index create show], param: :url
  get ':url', to: 'urls#visit', as: :visit

  scope '/api' do
    scope 'v1', :defaults=>{:format=>:json} do
      post '/latest_urls_data' => "api/v1/urls#get_latest_urls_data"
    end
  end
end
