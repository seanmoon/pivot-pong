class MatchesController < ApplicationController
  include MatchesHelper

  def create
    match = Match.new(params[:match])
    match.save
    redirect_to matches_path
  end

  def destroy
    Match.find(params[:id]).destroy
    redirect_to matches_path
  end

  def index
    @match = Match.new
    @matches = Match.order("date")
  end

  def new
    @match = Match.new
  end

  def rankings
    matches = Match.order("date")
    @rankings = calculate_rankings(matches)
  end

  def update
    match = Match.find_by_id(params[:id])
    match.update_attributes(params[:match])
    redirect_to matches_path
  end
end
