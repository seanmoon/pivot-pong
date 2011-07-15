class MatchesController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :create

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
    @matches = Match.order("occured_at desc")
  end

  def rankings
    all_matches = Match.order("occured_at asc")
    last_30_days_matches = Match.where("occured_at >= ?", 30.days.ago).order("occured_at asc")
    last_90_days_matches = Match.where("occured_at >= ?", 90.days.ago).order("occured_at asc")
    @rankings = calculate_rankings(all_matches)
    @last_30_days_rankings = calculate_rankings(last_30_days_matches)
    @last_90_days_rankings = calculate_rankings(last_90_days_matches)
  end

  def players
    if params[:q]
      query = params[:q].downcase + '%'
      names = Match.where(["LOWER(winner) LIKE ?", query]).collect(&:winner) + Match.where(["LOWER(loser) LIKE ?", query]).collect(&:loser)
    else
      names = Match.all.collect {|m| [m.winner, m.loser]}.flatten
    end

    render text: names.collect(&:downcase).sort.uniq.collect(&:titleize).join("\n")
  end
end
