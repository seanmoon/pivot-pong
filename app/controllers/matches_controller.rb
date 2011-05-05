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
    matches = Match.order("occured_at asc")
    @rankings = calculate_rankings(matches)
  end

  def players
    if params[:q]
      names = Match.where(["winner LIKE ?", params[:q] + '%']).collect(&:winner) + Match.where(["loser LIKE ?", params[:q] + '%']).collect(&:loser)
    else
      names = Match.all.collect {|m| [m.winner, m.loser]}.flatten
    end

    render text: names.collect(&:downcase).sort.uniq.collect(&:titleize).join("\n")
  end
end
