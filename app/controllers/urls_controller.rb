# frozen_string_literal: true

class UrlsController < ApplicationController

  def index
    @url = Url.new
    @urls = Url.latest
  end

  def create
    # create a new URL record
    @url = Url.create(original_url:url_params[:original_url],short_url:Url.generate_short_url)
    if @url.valid?
      flash[:notice] = "Original url saved successfully and short url generated"
      redirect_to urls_path
    else
      flash[:notice] = @url.errors.full_messages
      redirect_to urls_path and return 
    end   
  end

  def show
    @url = Url.find_by_short_url(params[:url])
    if @url.nil?
      flash[:notice] = "Url does not exist"
      redirect_to urls_path and return
    end  
    # implement queries
    metrics = @url.get_usage_metrics
    @daily_clicks = metrics[:daily_clicks]
    @browsers_clicks = metrics[:browsers_clicks]
    @platform_clicks = metrics[:platform_clicks]
  end

  def visit
    # params[:url]
    # @url = find url
    @url = Url.find_by_short_url(params[:url])
    if @url.nil?
      flash[:notice] = "Url does not exist in our DB"
      redirect_to urls_path and return
    elsif !@url.valid?
      render :file=>'public/404.html', status: 404 and return
    end   
    @url.update_attribute(:clicks_count,@url.clicks_count + 1) 
    browser = Browser.new(request.headers['User-Agent'], accept_language: request.headers["Accept-Language"])
    @url.clicks.create(browser:browser.name,platform:browser.platform.name)
    redirect_to @url.original_url
  end
  private
  def url_params
    params.require(:url).permit(:original_url)
  end  
end
