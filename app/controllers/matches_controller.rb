class MatchesController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :create

  def create
    winner, loser = params.values_at(:winner_name, :loser_name).map { |name|
      Player.find_or_create_by_name name.strip.downcase
    }

    match = Match.new winner: winner, loser: loser

    unless [winner, loser].all?(&:valid?) && match.save
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
    @rankings = MatchPoint.rankings
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
