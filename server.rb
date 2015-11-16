require "sinatra"
require 'json'

teams_hash = JSON.parse(File.read("roster.json"))
set :public_folder, File.join(File.dirname(__FILE__), "public")

teams = ""
teams_hash.each do |name, players|
  teams += name
end

get "/teams" do
  @teams = teams_hash
  erb :teams
end

get "/teams/:team_name" do
  @teams = teams_hash
  @name = params[:team_name]
  erb :team
end

get "/positions" do
  @positions = []
  teams_hash.each do |team, players|
    players.each do |position, name|
      if !@positions.include?(position)
        @positions << position
      end
    end
  end
  erb :positions
end

get "/positions/:position" do
  @position_name = params[:position]
  erb :position
end
