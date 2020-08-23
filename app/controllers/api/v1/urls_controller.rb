class Api::V1::UrlsController < ApplicationController
  skip_before_action :verify_authenticity_token  

  def get_latest_urls_data
    urls = Url.latest
    data = []
    urls.each do |url|
        metrics = url.get_usage_metrics
        data << {type:"urls",
                    id:url.id,
                attributes:{created_at:url.created_at,
                    original_url:url.original_url,
                    url:visit_url(url.short_url),
                    clicks:url.clicks_count},
                relationships:{metrics:{
                    data:[{daily_clicks:metrics[:daily_clicks]},{browsers_clicks:metrics[:browsers_clicks]},
                    {platform_clicks:metrics[:platform_clicks]}]
                }},included:[]}
    end    
    render json: {success: true, data:data}, status:200
  end      

end    