require 'rubygems'
require 'sinatra'

ASSET_DIR = ENV['ASSET_DIR'] ||= File.expand_path('../public/assets', __FILE__)


class Asset
  attr_reader :id
  def initialize(id)
    @id = id
  end
  
  def filename
    @filename ||= Dir["#{ASSET_DIR}/#{id}*"][0].to_s
  end
  
  def file?
    filename != ''
  end
  
  def path
    "/assets/#{File.basename(filename)}"
  end
end


class Story
  def requested_by; "Greg Bell" end
  
  def owned_by; "Sam Vincent" end
  
  def name
    "As a user, I should be able to login to the system."
  end
  
  def description
    "This is the description\n--\nWF.0.1\nWF.1.0"
  end
  
  def asset_ids
    @asset_ids ||= description.split("\n--\n")[1].to_s
  end
  
  def assets
    asset_ids.split("\n").collect{|id| Asset.new(id) }
  end
  
end





get "/stories/:id" do
  @story = Story.new
  
  erb :show_story
end