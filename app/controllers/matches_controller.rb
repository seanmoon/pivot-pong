class MatchesController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :create

  include MatchesHelper

  def create
    params[:match] ||= {}
    params[:match][:winner] = Player.find_or_create_by_name(params[:winner_name].downcase)
    params[:match][:loser] = Player.find_or_create_by_name(params[:loser_name].downcase)

    if params[:match][:winner].valid? &&params[:match][:loser].valid?
      match = Match.new(params[:match])
      match.save
    else
      flash.alert = "Must specify a winner and a loser to post a match."
    end
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
    @rankings = Player.active.ranked
  end

  def players
    if params[:q]
      query = params[:q].downcase + '%'
      names = Player.where(["LOWER(name) LIKE ?", query]).collect(&:name)
    else
      names = Player.all.collect(&:name)
    end

    render text: names.collect(&:downcase).sort.uniq.collect(&:titleize).join("\n")
  end
end
