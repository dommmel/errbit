require 'rufus/scheduler'
scheduler = Rufus::Scheduler.start_new

if Rails.env.production?
  url = ENV["HOSTNAME"] || "errbyte.herokuapp.com"
  scheduler.every '30m' do
    require "net/http"
    require "uri"
    uri = URI.parse("https://#{url}")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.get(uri.request_uri)
  end
end