require 'sinatra'
# we need to require this gem to open a json URL
require 'open-uri'
require ("http")
require ("json")
require "sinatra/reloader"



get('/') do
  raw = HTTP.get("https://api.exchangerate.host/symbols")
  kys = JSON.parse(raw)
  #check = kys.at(1)
  @simb = kys.fetch("symbols")
  @simb.each do |prin|
    @lis = prin.at(1)
    @cde = @lis.fetch("code")
    # @code_array = Array.new
    # @code_array = @cde.push
  end
  erb(:main)
end

get('/:cde') do
  @cde= params.fetch("cde")
  rawtwo = HTTP.get("https://api.exchangerate.host/symbols")
  kystwo = JSON.parse(rawtwo)
  #check = kys.at(1)
  @simbtwo = kystwo.fetch("symbols")
  @simbtwo.each do |printwo|
    @listwo = printwo.at(1)
    @cdetwo = @listwo.fetch("code")
    # @code_array = Array.new
    # @code_array = @cde.push
  end

  erb(:tocurrency)
end

get('/:cde/:cdetwo') do
  @cde = params.fetch("cde")
  @cdetwo = params.fetch("cdetwo")
  pp @cde

  rawfinal = HTTP.get("https://api.exchangerate.host/convert?from=#{@cde}&to=#{@cdetwo}")
  keysfinal = JSON.parse(rawfinal)
  @simbfinal = keysfinal.fetch("info")
  erb(:conversion)
end
