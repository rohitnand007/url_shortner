# frozen_string_literal: true

class Url < ApplicationRecord
  scope :latest, ->() {order(updated_at: :desc).limit(10)}
  has_many :clicks
  validates_presence_of :original_url, on: :create, message: "can't be blank"
  validates_uniqueness_of :short_url, on: :create, message: "must be unique"
  validates_length_of :original_url, within: 3..255, on: :create, message: "too long"
  validates_length_of :short_url, within: 3..5, on: :create, message: "too long"
  validates :original_url, format: URI::regexp(%w[http https])

  def self.generate_short_url
    all_codes = pluck(:short_url)
    new_code = SecureRandom.alphanumeric(5)
    while all_codes.include?(new_code) do
      new_code = SecureRandom.alphanumeric(5)
    end
    return new_code
  end
  
  def get_usage_metrics
    results = {}
    all_clicks = clicks
    results[:daily_clicks] = all_clicks.group_by{|t| t.updated_at.strftime("%d")}.map{|k,v| [k,v.count]}
    results[:browsers_clicks] = all_clicks.group(:browser).count.map{|k,v| [k,v]}
    results[:platform_clicks] = all_clicks.group(:platform).count.map{|k,v| [k,v]}
    return results
  end  

end
